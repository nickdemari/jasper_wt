import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : super(const LoginState(status: LoginStatus.initial));

  final AuthenticationRepository _authenticationRepository;

  Future<void> loginAnomnesly() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authenticationRepository.loginAnomnesly();
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
