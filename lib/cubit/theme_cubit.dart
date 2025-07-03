import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Default to light mode

  void toggleTheme() {
    emit(!state);
  }

  void setTheme(bool isDarkMode) {
    emit(isDarkMode);
  }

  bool get isDarkMode => state;
  bool get isLightMode => !state;
}
