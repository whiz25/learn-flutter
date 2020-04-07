import 'package:flutter/material.dart';
import 'package:flutter_random_gif/UI/gif.dart';
import 'package:flutter_random_gif/UI/gif_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gifService = GifPage();
    return new MaterialApp(
      title: 'Flutter Random Gif',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Giphy Random', gifPage: GifPage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final GifPage gifPage;
  final String title;

  MyHomePage({Key key, this.title, this.gifPage}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(gifPage);
}

class _MyHomePageState extends State<MyHomePage> {
  final GifPage gifPage;

  String _tag = "";

  _MyHomePageState(this.gifPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            _buildRandom(),
          ],
        ),
        body: ListView(children: [
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.only(top: 24.0, bottom: 36.0),
                child: _buildCategorySearchInput(),
              ),
              FutureBuilder<Gif>(
                  future: gifPage.fetchImageUrlAsync(_tag),
                  builder: _buildImage),
            ]),
          ),
        ]));
  }

  Widget _buildCategorySearchInput() {
    return Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        ),
      ),
    );
  }

  Widget _buildRandom() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
          onPressed: _refreshImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Random Gif!"),
              ),
            ],
          )),
    );
  }

  void _refreshImage() {
    setState(() {});
  }

  Widget _buildImage(_, AsyncSnapshot<Gif> snapshot) {
    if (snapshot.hasData) {
      return Image.network(snapshot.data.url);
    }
    return CircularProgressIndicator();
  }
}