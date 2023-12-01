part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.errorMessage,
    required this.status,
  });

  final LoginStatus status;

  final String? errorMessage;

  @override
  List<Object> get props => [];

  LoginState copyWith({
    String? errorMessage,
    required LoginStatus status,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: this.status,
    );
  }
}

enum LoginStatus { initial, loading, success, error }
