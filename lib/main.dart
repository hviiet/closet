import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/hive_adapters.dart';
import 'models/clothing_item.dart';
import 'models/outfit_set.dart';
import 'models/collection.dart';
import 'repositories/hive_clothing_repository.dart';
import 'repositories/hive_outfit_repository.dart';
import 'repositories/hive_collection_repository.dart';
import 'services/file_storage_service.dart';
import 'services/image_processing_service.dart';
import 'bloc/clothing_bloc.dart';
import 'bloc/clothing_event.dart';
import 'cubit/filter_cubit.dart';
import 'cubit/outfit_cubit.dart';
import 'cubit/collection_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'constants/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(ClothingCategoryAdapter());
  Hive.registerAdapter(ClothingItemAdapter());
  Hive.registerAdapter(OutfitSetAdapter());
  Hive.registerAdapter(CollectionAdapter());

  // Load initial theme state
  final initialTheme = await ThemeCubit.getInitialTheme();

  runApp(TClosetApp(initialTheme: initialTheme));
}

class TClosetApp extends StatelessWidget {
  final bool initialTheme;

  const TClosetApp({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FileStorageService>(
          create: (context) => FileStorageService(),
        ),
        RepositoryProvider<ImageProcessingService>(
          create: (context) => ImageProcessingService(
            context.read<FileStorageService>(),
          ),
        ),
        RepositoryProvider<HiveClothingRepository>(
          create: (context) => HiveClothingRepository(),
        ),
        RepositoryProvider<HiveOutfitRepository>(
          create: (context) => HiveOutfitRepository(),
        ),
        RepositoryProvider<HiveCollectionRepository>(
          create: (context) => HiveCollectionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ClothingBloc>(
            create: (context) => ClothingBloc(
              clothingRepository: context.read<HiveClothingRepository>(),
            )..add(LoadClothingItems()),
          ),
          BlocProvider<FilterCubit>(
            create: (context) => FilterCubit(),
          ),
          BlocProvider<OutfitCubit>(
            create: (context) => OutfitCubit(),
          ),
          BlocProvider<CollectionCubit>(
            create: (context) => CollectionCubit(
              context.read<HiveCollectionRepository>(),
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(initialTheme),
          ),
        ],
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return MaterialApp(
              title: 'TCloset',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: const AppInitializer(),
            );
          },
        ),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Store repositories before async operations
      final clothingRepo = context.read<HiveClothingRepository>();
      final outfitRepo = context.read<HiveOutfitRepository>();
      final collectionRepo = context.read<HiveCollectionRepository>();

      // Initialize repositories
      await clothingRepo.init();
      await outfitRepo.init();
      await collectionRepo.init();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      // Handle initialization error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Initialization failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Initializing TCloset...'),
            ],
          ),
        ),
      );
    }

    return const MainNavigationScreen();
  }
}
