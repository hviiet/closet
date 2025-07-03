import 'package:hive/hive.dart';
import 'clothing_category.dart';

class ClothingCategoryAdapter extends TypeAdapter<ClothingCategory> {
  @override
  final int typeId = 3;

  @override
  ClothingCategory read(BinaryReader reader) {
    final index = reader.readByte();
    return ClothingCategory.values[index];
  }

  @override
  void write(BinaryWriter writer, ClothingCategory obj) {
    writer.writeByte(obj.index);
  }
}
