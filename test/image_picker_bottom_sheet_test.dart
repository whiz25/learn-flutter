import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/image_picker_bottom_sheet.dart'
as ImagePickerBottomSheet;

void main() {
  testWidgets(
      'Bottom sheet should appear and show choose from gallery or take a new picture text',
          (WidgetTester tester) async {
        BuildContext savedContext;

        await tester
            .pumpWidget(MaterialApp(home: Builder(builder: (BuildContext context) {
          savedContext = context;
          return Container();
        })));

        await tester.pump();
        expect(
            find.text(ImagePickerBottomSheet.kTakeANewPictureText), findsNothing);
        expect(
            find.text(ImagePickerBottomSheet.kChooseFromGalleryText), findsNothing);

        ImagePickerBottomSheet.showImagePickerBottomSheet(savedContext);

        await tester.pump(); // Bottom sheet show animation starts
        await tester.pump(const Duration(seconds: 2)); // animation done

        expect(find.text(ImagePickerBottomSheet.kChooseFromGalleryText),
            findsOneWidget);
        expect(
            find.text(ImagePickerBottomSheet.kTakeANewPictureText), findsOneWidget);
      });
}