import 'package:flutter_test/flutter_test.dart';
import 'package:login_api_bloc/feature/login/model/login_model.dart';
import 'package:login_api_bloc/feature/service/login_network_manager.dart';
import 'package:login_api_bloc/feature/service/login_service.dart';

void main() {
  late ILoginService loginService;
  setUp(() {
    loginService = LoginService(NetworkManagerLogin());
  });

  test('Login Test', () async {
    final response = await loginService
        .login(LoginModel('eve.holt@reqres.in', 'cityslicka'));

    expect(response?.data, isNotNull);
  });
}
