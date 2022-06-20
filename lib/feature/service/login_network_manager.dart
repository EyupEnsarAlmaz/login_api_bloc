import 'package:vexana/vexana.dart';

class NetworkManagerLogin extends NetworkManager {
  NetworkManagerLogin()
      : super(options: BaseOptions(baseUrl: 'https://reqres.in/'));
}
