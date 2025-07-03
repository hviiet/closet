import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'file_storage_service.dart';

class ImageProcessingService {
  final FileStorageService _fileStorageService;
  final _uuid = const Uuid();

  ImageProcessingService(this._fileStorageService);

  /// Remove background from image (placeholder implementation)
  /// In a real app, this would use ML Kit or similar
  Future<String> removeBackground(String imagePath) async {
    try {
      // Placeholder: For now, just copy the original image
      // In production, this would use ML Kit or a similar service
      final originalFile = File(imagePath);
      final processedPath = await _saveProcessedImage(originalFile);
      return processedPath;
    } catch (e) {
      throw Exception('Failed to remove background: $e');
    }
  }

  /// Compress and save image locally with UUID naming
  Future<String> saveImageLocally(File imageFile) async {
    try {
      final compressedFile = await _compressImage(imageFile);
      return await _fileStorageService.saveImage(compressedFile);
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  /// Compress image to reduce file size
  Future<File> _compressImage(File file) async {
    final String targetPath = path.join(
      path.dirname(file.path),
      '${_uuid.v4()}_compressed.jpg',
    );

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 85,
      minWidth: 800,
      minHeight: 800,
    );

    if (compressedFile == null) {
      throw Exception('Failed to compress image');
    }

    return File(compressedFile.path);
  }

  /// Save processed image with background removed
  Future<String> _saveProcessedImage(File originalFile) async {
    // Placeholder implementation - in real app this would apply background removal
    final compressedFile = await _compressImage(originalFile);
    return await _fileStorageService.saveImage(compressedFile);
  }

  /// Get optimized image for display
  Future<Uint8List?> getOptimizedImageBytes(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) return null;

      return await file.readAsBytes();
    } catch (e) {
      return null;
    }
  }
}
