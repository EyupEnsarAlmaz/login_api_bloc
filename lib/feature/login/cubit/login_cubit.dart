import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api_bloc/feature/login/cubit/login_cubit._state.dart';
import 'package:login_api_bloc/feature/login/model/login_model.dart';
import 'package:login_api_bloc/feature/service/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(LoginService loginService)
      : _loginService = loginService,
        super(LoginState());
  final ILoginService _loginService;

  Future<void> checkUser(String email, String password) async {
    emit(state.copyWith(isLoading: true, model: LoginModel(email, password)));
    await _loginService.login(state.model!);
    emit(state.copyWith(isLoading: false));
  }
}
