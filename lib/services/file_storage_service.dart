import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FileStorageService {
  static const String _imagesFolder = 'clothing_images';
  final _uuid = const Uuid();

  /// Get the app's documents directory
  Future<Directory> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final appDir = Directory(path.join(directory.path, 'tcloset'));
    if (!await appDir.exists()) {
      await appDir.create(recursive: true);
    }
    return appDir;
  }

  /// Get the images directory
  Future<Directory> _getImagesDirectory() async {
    final appDir = await _getAppDirectory();
    final imagesDir = Directory(path.join(appDir.path, _imagesFolder));
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    return imagesDir;
  }

  /// Save image to local storage with UUID naming
  Future<String> saveImage(File imageFile) async {
    try {
      final imagesDir = await _getImagesDirectory();
      final fileName = '${_uuid.v4()}.jpg';
      final targetPath = path.join(imagesDir.path, fileName);

      final savedFile = await imageFile.copy(targetPath);
      return savedFile.path;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  /// Delete image from local storage
  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  /// Check if image exists
  Future<bool> imageExists(String imagePath) async {
    try {
      final file = File(imagePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Get total storage used by images
  Future<int> getTotalStorageUsed() async {
    try {
      final imagesDir = await _getImagesDirectory();
      if (!await imagesDir.exists()) return 0;

      int totalSize = 0;
      await for (final entity in imagesDir.list(recursive: true)) {
        if (entity is File) {
          final stat = await entity.stat();
          totalSize += stat.size;
        }
      }
      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  /// Clean up orphaned images (images not referenced by any clothing item)
  Future<void> cleanupOrphanedImages(List<String> usedImagePaths) async {
    try {
      final imagesDir = await _getImagesDirectory();
      if (!await imagesDir.exists()) return;

      final usedPaths = usedImagePaths.toSet();

      await for (final entity in imagesDir.list()) {
        if (entity is File && !usedPaths.contains(entity.path)) {
          await entity.delete();
        }
      }
    } catch (e) {
      throw Exception('Failed to cleanup orphaned images: $e');
    }
  }
}
