import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'repositories/supabase_clothing_repository.dart';
import 'repositories/supabase_outfit_repository.dart';
import 'repositories/supabase_collection_repository.dart';
import 'services/image_processing_service.dart';
import 'services/image_bb_service.dart';
import 'bloc/clothing_bloc.dart';
import 'bloc/clothing_event.dart';
import 'cubit/filter_cubit.dart';
import 'cubit/outfit_cubit.dart';
import 'cubit/collection_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/auth_cubit.dart';
import 'constants/app_theme.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

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
        RepositoryProvider<ImageProcessingService>(
          create: (context) {
            return ImageProcessingService(
              imageBBService:
                  ImageBBService(apiKey: dotenv.env['IMG_BB_KEY'] ?? ''),
            );
          },
        ),
        RepositoryProvider<SupabaseClothingRepository>(
          create: (context) => SupabaseClothingRepository(),
        ),
        RepositoryProvider<SupabaseOutfitRepository>(
          create: (context) => SupabaseOutfitRepository(),
        ),
        RepositoryProvider<SupabaseCollectionRepository>(
          create: (context) => SupabaseCollectionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(initialTheme),
          ),
        ],
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<ClothingBloc>(
                  create: (context) => ClothingBloc(
                    clothingRepository:
                        context.read<SupabaseClothingRepository>(),
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
                    context.read<SupabaseCollectionRepository>(),
                  ),
                ),
              ],
              child: MaterialApp(
                title: 'TCloset',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (context) => const AuthWrapper(),
                  '/auth': (context) => const AuthScreen(),
                  '/main': (context) => const MainWrapper(),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AppAuthState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        }

        if (state.isAuthenticated) {
          return const MainWrapper();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigationScreen();
  }
}
