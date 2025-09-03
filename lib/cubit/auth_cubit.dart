import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppAuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final User? user;

  const AppAuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.user,
  });

  AppAuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    User? user,
  }) {
    return AppAuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      user: user ?? this.user,
    );
  }
}

class AuthCubit extends Cubit<AppAuthState> {
  final supabase = Supabase.instance.client;

  AuthCubit() : super(const AppAuthState()) {
    _initializeAuth();
  }

  void _initializeAuth() {
    // Check if user is already signed in
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      emit(AppAuthState(
        isAuthenticated: true,
        user: currentUser,
      ));
    }

    // Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      final user = session?.user;

      emit(AppAuthState(
        isAuthenticated: session != null,
        user: user,
        errorMessage: null,
        successMessage: null,
      ));
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AppAuthState(
      isAuthenticated: state.isAuthenticated,
      isLoading: true,
      errorMessage: null,
      successMessage: null,
      user: state.user,
    ));

    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Show success message - the auth state change listener will handle the authentication state
      emit(AppAuthState(
        isAuthenticated: state.isAuthenticated,
        isLoading: false,
        errorMessage: null,
        successMessage: 'Sign in successful! Welcome back.',
        user: state.user,
      ));
    } catch (e) {
      emit(AppAuthState(
        isAuthenticated: state.isAuthenticated,
        isLoading: false,
        errorMessage: 'Sign in failed: ${e.toString()}',
        successMessage: null,
        user: state.user,
      ));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(AppAuthState(
      isAuthenticated: state.isAuthenticated,
      isLoading: true,
      errorMessage: null,
      successMessage: null,
      user: state.user,
    ));

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Check if user needs email confirmation
      if (response.user != null && response.session == null) {
        // Email confirmation required
        emit(AppAuthState(
          isAuthenticated: state.isAuthenticated,
          isLoading: false,
          errorMessage: null,
          successMessage:
              'Account created! Please check your email to confirm your account.',
          user: state.user,
        ));
      } else if (response.user != null && response.session != null) {
        // User is immediately signed in (no email confirmation required)
        emit(AppAuthState(
          isAuthenticated: state.isAuthenticated,
          isLoading: false,
          errorMessage: null,
          successMessage: 'Account created successfully! Welcome to TCloset.',
          user: state.user,
        ));
      } else {
        // Fallback success message
        emit(AppAuthState(
          isAuthenticated: state.isAuthenticated,
          isLoading: false,
          errorMessage: null,
          successMessage: 'Account created successfully!',
          user: state.user,
        ));
      }
    } catch (e) {
      emit(AppAuthState(
        isAuthenticated: state.isAuthenticated,
        isLoading: false,
        errorMessage: 'Sign up failed: ${e.toString()}',
        successMessage: null,
        user: state.user,
      ));
    }
  }

  Future<void> signOut() async {
    emit(AppAuthState(
      isAuthenticated: state.isAuthenticated,
      isLoading: true,
      errorMessage: null,
      successMessage: null,
      user: state.user,
    ));

    try {
      await supabase.auth.signOut();

      emit(const AppAuthState(
        isAuthenticated: false,
        isLoading: false,
        errorMessage: null,
        successMessage: null,
        user: null,
      ));
    } catch (e) {
      emit(AppAuthState(
        isAuthenticated: state.isAuthenticated,
        isLoading: false,
        errorMessage: 'Sign out failed: ${e.toString()}',
        successMessage: null,
        user: state.user,
      ));
    }
  }

  Future<void> refreshSession() async {
    try {
      await supabase.auth.refreshSession();
    } catch (e) {
      emit(AppAuthState(
        isAuthenticated: state.isAuthenticated,
        isLoading: false,
        errorMessage: 'Session refresh failed: ${e.toString()}',
        successMessage: null,
        user: state.user,
      ));
    }
  }
}
