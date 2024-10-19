import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../data/resource/domain/entity/login_entity.dart';
import '../../data/resource/domain/usecases/login_usecase.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthProvider(this.loginUseCase);

  bool _isLoading = false;
  String _emailError = '';
  String _passwordError = '';
  String _serverError = '';
  String _success = '';

  // Getters for the state
  bool get isLoading => _isLoading;
  String get emailError => _emailError;
  String get passwordError => _passwordError;
  String get serverError => _serverError;
  String get success => _success;

  // Setters
  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners(); // Notify UI when _isLoading changes
    }
  }

  set emailError(String error) {
    _emailError = error;
  }

  set passwordError(String error) {
    _passwordError = error;
  }

  set serverError(String error) {
    _serverError = error;
  }

  set success(String message) {
    _success = message;
  }

  void setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  void setPasswordError(String error) {
    _passwordError = error;
    notifyListeners();
  }

  void setServerError(String error) {
    _serverError = error;
    notifyListeners();
  }

  void setSuccess(String message) {
    _success = message;
    notifyListeners();
  }

  // Login method
  Future<void> login(String email, String password) async {
    isLoading = true; // Use the setter to update the loading state
    emailError = '';
    passwordError = '';
    serverError = '';
    success = '';

    // Create a LoginEntity instance
    final loginEntity = LoginEntity(email: email, password: password);
    final result = await loginUseCase(LoginParams(user: loginEntity));

    result.fold(
      (failure) {
        isLoading = false; // Stop loading
        // Handle different types of failures
        if (failure is InvalidUserCredentialFailure) {
          emailError = 'Invalid email or password.';
        } else {
          serverError = 'An error occurred. Please try again.';
        }
      },
      (_) {
        isLoading = false; // Stop loading
        success = 'Login successful!';
      },
    );
  }
}
