import 'package:login_api_bloc/feature/login/model/login_model.dart';
import 'package:login_api_bloc/product/model/token_model.dart';
import 'package:vexana/vexana.dart';

abstract class ILoginService {
  final INetworkManager networkManager;
  final _loginPath = 'api/login';

  ILoginService(this.networkManager);
  Future<IResponseModel<TokenModel?>?> login(LoginModel model);
}

class LoginService extends ILoginService {
  LoginService(super.networkManager);

  Future<IResponseModel<TokenModel?>?> login(LoginModel model) async {
    return await networkManager.send<TokenModel, TokenModel>(_loginPath,
        data: model, parseModel: TokenModel(), method: RequestType.POST);
  }
}
