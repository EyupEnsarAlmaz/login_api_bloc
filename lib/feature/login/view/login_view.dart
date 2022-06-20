import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:login_api_bloc/feature/login/cubit/login_cubit._state.dart';
import 'package:login_api_bloc/feature/login/cubit/login_cubit.dart';
import 'package:login_api_bloc/feature/service/login_network_manager.dart';
import 'package:login_api_bloc/feature/service/login_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String _title = "Login with Cubit";
  final String _loginText = "Login";
  final GlobalKey<FormState> _formLoginKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(LoginService(NetworkManagerLogin())),
      child: Scaffold(
        appBar: AppBar(title: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return state.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const SizedBox();
          },
        )),
        body: Form(
            key: _formLoginKey,
            child: Padding(
              padding: const MyPadding.all(),
              child: Column(children: [
                _loginViewWidget(
                    controller: _emailController,
                    passwordController: _passwordController),
                _loginButton(
                    formLoginKey: _formLoginKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loginText: _loginText)
              ]),
            )),
      ),
    );
  }
}

class _loginButton extends StatelessWidget {
  const _loginButton({
    Key? key,
    required GlobalKey<FormState> formLoginKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String loginText,
  })  : _formLoginKey = formLoginKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _loginText = loginText,
        super(key: key);

  final GlobalKey<FormState> _formLoginKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final String _loginText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              if (_formLoginKey.currentState?.validate() ?? false) {
                context
                    .read<LoginCubit>()
                    .checkUser(_emailController.text, _passwordController.text);
              }
            },
            child: Text(_loginText));
      },
    );
  }
}

class _loginViewWidget extends StatelessWidget {
  _loginViewWidget({
    Key? key,
    required TextEditingController controller,
    required TextEditingController passwordController,
  })  : _emailController = controller,
        _passwordController = passwordController,
        super(key: key);

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (String? data) =>
                (data?.isValidEmail ?? false) ? null : 'Hatalı Mail'),
        TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (String? data) =>
                ((data?.length ?? 0) > 6) ? null : 'Hatalı Sifre'),
      ],
    );
  }
}

class MyPadding extends EdgeInsets {
  const MyPadding.all() : super.all(20);
}
