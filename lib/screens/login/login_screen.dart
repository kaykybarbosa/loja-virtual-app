import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/validators/validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void _formSubmitted() {
    if (_formKey.currentState!.validate()) {
      context.read<UserManager>().signIn(
            email: _emailController.text,
            password: _passwordController.text,
            onFail: (error) {
              customSnackbar(
                context,
                message: error,
                type: AnimatedSnackBarType.error,
              );
            },
          );
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Entrar'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  /// E-mail
                  const _Email(),

                  const Gap(16),

                  /// Senha
                  const _Password(),

                  /// Esquece a senha
                  const _FogortPasswordBtn(),

                  const Gap(16),

                  /// Submit
                  _SubmitBtn(_formSubmitted),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(builder: (_, userManager, __) {
        return TextFormField(
          enabled: !userManager.isLoading,
          controller: context.findAncestorStateOfType<_LoginScreenState>()?._emailController,
          decoration: const InputDecoration(hintText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
          validator: (email) {
            if (email == null || !emailValid(email)) {
              return 'E-mail inválido';
            }
            return null;
          },
        );
      });
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(builder: (_, userManager, __) {
        return TextFormField(
          obscureText: true,
          enabled: !userManager.isLoading,
          controller: context.findAncestorStateOfType<_LoginScreenState>()?._passwordController,
          decoration: const InputDecoration(hintText: 'Senha'),
          validator: (password) {
            if (password == null || password.isEmpty || password.length < 6) {
              return 'Senha inválida';
            }
            return null;
          },
        );
      });
}

class _FogortPasswordBtn extends StatelessWidget {
  const _FogortPasswordBtn();

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: const Text('Esqueci a senha'),
        ),
      );
}

class _SubmitBtn extends StatelessWidget {
  const _SubmitBtn(this.onPressed);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(
        builder: (_, userManager, __) => ElevatedButton(
          onPressed: userManager.isLoading ? null : onPressed,
          child: userManager.isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator.adaptive())
              : const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
        ),
      );
}
