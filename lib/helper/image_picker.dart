import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SaiImagePicker {
  SaiImagePicker() {}
  static Future<SaiImage?> pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print('object');
      return SaiImage(
          BASE64: base64Encode(File(pickedImage.path).readAsBytesSync()),
          image: File(pickedImage.path));
    }
  }
}

class SaiImage {
  final File image;
  final String BASE64;

  SaiImage({required this.image, required this.BASE64});
}

// // functions
// pickImage() async {
//   XFile? image = await myImagePicker.pickImage();
//   if (image != null) {
//     // do what u want with image
//   }
// }

// // pick image and post it

// pickImageAndPostIt(
//     {required String url,
//     required String token,
//     required String field,
//     onEnd}) async {
//   XFile? image = await myImagePicker.pickImage();
//   if (image != null) {
//     File i = File(image.path);
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath(field, i.path,
//         filename: i.path.split('/').last));
//     request.headers['Authorization'] = 'Bearer ${token}';
//     request.headers['Accept'] = 'application/json';
//     http.StreamedResponse _res;
//     _res = await request.send();

//     http.Response r = await http.Response.fromStream(_res);
//     onEnd();
//   }
// }
