enum ClothingCategory {
  tops,
  bottoms,
  shoes,
  accessories,
  outerwear,
  underwear,
  sleepwear,
  sportswear;

  String get displayName {
    switch (this) {
      case ClothingCategory.tops:
        return 'Tops';
      case ClothingCategory.bottoms:
        return 'Bottoms';
      case ClothingCategory.shoes:
        return 'Shoes';
      case ClothingCategory.accessories:
        return 'Accessories';
      case ClothingCategory.outerwear:
        return 'Outerwear';
      case ClothingCategory.underwear:
        return 'Underwear';
      case ClothingCategory.sleepwear:
        return 'Sleepwear';
      case ClothingCategory.sportswear:
        return 'Sportswear';
    }
  }
}
