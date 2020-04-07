import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_random_gif/UI/gif.dart';
import 'package:http/http.dart' as http;

class GifPage {
  

  static const String url = "https://api.giphy.com/v1/gifs/random?api_key=HmOyOJcTd97wVdso4dglANeFFVvUHWf8&tag=25&rating=G";
  String apiKey = "";

  Future<Gif> fetchImageUrlAsync(String tag) async {
    if (apiKey.isEmpty) {
      await DotEnv().load('.env');
      DotEnv().env["api_key"];
    }
    var requestEndpoint = "$url$apiKey&tag=$tag";
    final response = await http.get(requestEndpoint);
    if (response.statusCode == 200) {
      return Gif.fromJson(json.decode(response.body));
    }
    return null;
  }
}