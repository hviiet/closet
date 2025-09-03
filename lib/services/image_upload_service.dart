import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploadService {
  final String apiKey;

  ImageUploadService(this.apiKey);

  Future<String?> uploadImage(File imageFile) async {
    final uri = Uri.parse('https://api.imghippo.com/v1/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['api_key'] = apiKey
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);
      if (jsonResponse['success'] == true) {
        return jsonResponse['data']['url'];
      } else {
        throw Exception('Image upload failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to upload image. Status code: ${response.statusCode}');
    }
  }
}
