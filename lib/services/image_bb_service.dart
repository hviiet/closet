import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageBBService {
  final String apiKey;
  final Uri _uploadEndpoint = Uri.parse('https://api.imgbb.com/1/upload');

  ImageBBService({required this.apiKey});

  /// Uploads an image file to ImgBB and returns the direct image URL.
  Future<String> uploadImage(File imageFile, {String? title}) async {
    if (apiKey.isEmpty) {
      throw Exception(
          'ImgBB API key is not set. Pass via --dart-define=IMG_BB_KEY=YOUR_KEY');
    }

    final request = http.MultipartRequest('POST', _uploadEndpoint);
    request.headers['Accept'] = 'application/json';

    // Per API docs: key, image (as file), optional name
    request.fields['key'] = apiKey;
    if (title != null && title.isNotEmpty) {
      request.fields['name'] = title;
    }
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
          'Upload failed with status ${response.statusCode}: ${response.body}');
    }

    final Map<String, dynamic> jsonBody =
        json.decode(response.body) as Map<String, dynamic>;
    final bool success = jsonBody['success'] == true;
    if (!success) {
      final message = jsonBody['status']?.toString() ?? 'Unknown error';
      throw Exception('Upload failed: $message');
    }

    final data = jsonBody['data'] as Map<String, dynamic>?;
    final url = (data?['url'] ?? data?['url_viewer'])?.toString();
    if (url == null || url.isEmpty) {
      throw Exception(
          'Upload succeeded but no URL returned. Response: ${response.body}');
    }
    return url;
  }
}
