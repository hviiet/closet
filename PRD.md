# Flutter Closet App - Product Requirements Document

## 1. Overview

A Flutter mobile application that allows users to digitally organize their wardrobe by capturing, categorizing, and managing clothing items locally on their device. The app enables users to create outfit combinations and pack for trips efficiently.

## 2. Core Features

### 2.1 Clothing Item Management
- **Image Capture & Processing**: Users can photograph clothing items using device camera
- **Background Removal**: Automatic background removal to isolate clothing items
- **Local Storage**: All images stored locally on device with UUID-based naming
- **Categorization**: Clothing items organized by categories (tops, bottoms, shoes, accessories, etc.)
- **Metadata Storage**: Item details stored using Hive database locally

### 2.2 Inventory Display
- **Main Screen**: Display all clothing items in a grid/list view
- **Category Filtering**: Filter items by specific categories
- **Date Sorting**: Sort items by date added (newest/oldest first)
- **Search Functionality**: Quick search through clothing items

### 2.3 Outfit Creation
- **Set Builder Screen**: Interface to select multiple items for complete outfits
- **Category Selection**: Choose items from different categories (top, bottom, shoes, accessories)
- **Outfit Preview**: Visual representation of selected outfit combination
- **Save Outfits**: Store created outfit sets for future reference

### 2.4 Trip Planning
- **Trip Packing Feature**: Select clothing items and outfit sets for specific trips
- **Trip Management**: Create, edit, and manage multiple trips
- **Packing List**: Generate packing lists based on selected items

## 3. Technical Requirements

### 3.1 Architecture
- **Design Pattern**: MVVM (Model-View-ViewModel) architecture
- **State Management**: BLoC pattern with Cubit for simpler state management
- **Data Models**: Freezed for immutable data classes and unions
- **Database**: Hive for local NoSQL storage

### 3.2 Data Storage
- **Local Storage Only**: No external servers or cloud storage
- **Image Storage**: Images saved locally with UUID naming convention
- **Database**: Hive boxes for structured data storage
- **File Organization**: Organized folder structure for different data types

### 3.3 Image Processing
- **Camera Integration**: Native camera functionality
- **Background Removal**: ML/AI-based background removal processing
- **Image Optimization**: Compress and optimize images for storage efficiency
- **Format Support**: Support for common image formats (JPEG, PNG)

## 4. Data Models

### 4.1 Clothing Item
```dart
// Using Freezed for immutable data classes
@freezed
class ClothingItem with _$ClothingItem {
  const factory ClothingItem({
    required String id,
    required String imagePath,
    required ClothingCategory category,
    required DateTime dateAdded,
    String? notes,
    List<String>? tags,
  }) = _ClothingItem;
}
```

### 4.2 Clothing Category
```dart
enum ClothingCategory {
  tops,
  bottoms,
  shoes,
  accessories,
  outerwear,
  underwear,
  sleepwear,
  sportswear,
}
```

### 4.3 Outfit Set
```dart
@freezed
class OutfitSet with _$OutfitSet {
  const factory OutfitSet({
    required String id,
    required String name,
    required List<String> itemIds,
    required DateTime dateCreated,
    String? notes,
    List<String>? tags,
  }) = _OutfitSet;
}
```

### 4.4 Trip
```dart
@freezed
class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> itemIds,
    required List<String> outfitIds,
    String? destination,
    String? notes,
  }) = _Trip;
}
```

## 5. Screen Specifications

### 5.1 Main Screen (Home)
- **Grid/List Toggle**: Switch between grid and list view
- **Category Filters**: Horizontal scrollable category chips
- **Sort Options**: Date added, category, name
- **Search Bar**: Real-time search functionality
- **FAB**: Add new clothing item

### 5.2 Add Item Screen
- **Camera Interface**: Native camera with capture button
- **Background Removal**: Processing indicator during background removal
- **Category Selection**: Dropdown or picker for category
- **Save/Cancel**: Action buttons for item management

### 5.3 Outfit Builder Screen
- **Category Sections**: Separate sections for each clothing category
- **Item Selection**: Tap to select/deselect items
- **Preview Area**: Visual representation of selected outfit
- **Save Outfit**: Name and save the outfit combination

### 5.4 Trip Planner Screen
- **Trip List**: Display created trips
- **Trip Details**: Show items and outfits for specific trip
- **Add Items**: Interface to add items and outfits to trip
- **Trip Management**: Create, edit, delete trips

## 6. Technical Implementation

### 6.1 State Management Structure
```dart
// BLoC for complex state management
class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  // Handle clothing item CRUD operations
}

// Cubit for simpler state management
class FilterCubit extends Cubit<FilterState> {
  // Handle filtering and sorting
}

class OutfitCubit extends Cubit<OutfitState> {
  // Handle outfit creation and management
}
```

### 6.2 Repository Pattern
```dart
abstract class ClothingRepository {
  Future<List<ClothingItem>> getAllItems();
  Future<void> addItem(ClothingItem item);
  Future<void> updateItem(ClothingItem item);
  Future<void> deleteItem(String id);
}

class HiveClothingRepository implements ClothingRepository {
  // Hive implementation
}
```

### 6.3 Services
```dart
class ImageProcessingService {
  Future<String> removeBackground(String imagePath);
  Future<String> saveImageLocally(File imageFile);
}

class FileStorageService {
  Future<String> saveImage(File image);
  Future<void> deleteImage(String path);
}
```

## 7. User Experience Requirements

### 7.1 Performance
- **App Launch**: App should launch within 2 seconds
- **Image Processing**: Background removal should complete within 5 seconds
- **Navigation**: Smooth transitions between screens
- **Storage**: Efficient local storage management

### 7.2 Usability
- **Intuitive Interface**: Simple and clean UI design
- **Accessibility**: Support for screen readers and accessibility features
- **Error Handling**: Clear error messages and recovery options
- **Offline Support**: Full functionality without internet connection

### 7.3 Storage Management
- **Storage Monitoring**: Track local storage usage
- **Image Optimization**: Compress images to save space
- **Data Backup**: Export/import functionality for data backup
- **Cache Management**: Efficient cache management for images

## 8. Development Phases

### Phase 1: Core Functionality
- Basic clothing item management
- Image capture and storage
- Category organization
- Main screen with basic filtering

### Phase 2: Advanced Features
- Background removal implementation
- Outfit creation functionality
- Enhanced filtering and sorting
- UI/UX improvements

### Phase 3: Trip Planning
- Trip management features
- Packing list functionality
- Advanced organization features
- Performance optimizations

## 9. Testing Requirements

### 9.1 Unit Testing
- Repository layer testing
- BLoC/Cubit state management testing
- Service layer testing
- Data model testing

### 9.2 Integration Testing
- Camera integration testing
- File storage testing
- Database operations testing
- Background removal testing

### 9.3 Widget Testing
- Screen widget testing
- User interaction testing
- Navigation testing
- Form validation testing

## 10. Platform Considerations

### 10.1 Android
- Camera permissions handling
- Storage permissions management
- Background processing optimization
- Material Design compliance

### 10.2 iOS
- Camera usage description
- Photo library access
- Background processing limitations
- Human Interface Guidelines compliance

## 11. Dependencies

### 11.1 Core Dependencies
- `flutter_bloc` - State management
- `hive` - Local database
- `freezed` - Code generation for data classes
- `uuid` - UUID generation
- `camera` - Camera functionality
- `image_picker` - Image selection
- `path_provider` - File system paths

### 11.2 Image Processing Dependencies
- ML Kit or similar for background removal
- `image` - Image manipulation
- `flutter_image_compress` - Image compression

## 12. Success Metrics

### 12.1 User Engagement
- Daily active users
- Session duration
- Feature usage statistics
- User retention rates

### 12.2 Technical Performance
- App crash rates
- Loading times
- Storage efficiency
- Battery usage optimization

## 13. Future Enhancements

### 13.1 Potential Features
- Color coordination suggestions
- Weather-based outfit recommendations
- Outfit sharing capabilities
- Wardrobe analytics and insights
- Integration with shopping apps
- AI-powered style recommendations

### 13.2 Technical Improvements
- Advanced ML models for better background removal
- Cloud sync option (with user consent)
- Enhanced search with visual similarity
- Augmented reality try-on features