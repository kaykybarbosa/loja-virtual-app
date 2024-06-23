import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/common/custom_form_field/custom_form_field.dart';
import 'package:lojavirtualapp/ui/common/submit_form_button.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:lojavirtualapp/utils/validators.dart';
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
            onSuccess: () => context.pushReplacement(AppRoutes.base),
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
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Entrar'),
          actions: <Widget>[
            IconButton(
              onPressed: () => context.push(AppRoutes.register),
              icon: const Text(
                'Criar conta',
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.base100,
                ),
              ),
            )
          ],
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
        ),
      );
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(
        builder: (_, userManager, __) => CustomFormField(
          hintText: 'E-mail',
          enabled: !userManager.isLoading,
          controller: context.findAncestorStateOfType<_LoginScreenState>()?._emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (email) {
            if (email == null || !emailValid(email)) {
              return 'E-mail inválido';
            }
            return null;
          },
        ),
      );
}

class _Password extends StatefulWidget {
  const _Password();

  @override
  State<_Password> createState() => _PasswordState();
}

class _PasswordState extends State<_Password> {
  bool _obscureText = true;

  set obscureText(bool value) => setState(() => _obscureText = value);

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(
        builder: (_, userManager, __) => CustomFormField(
          hintText: 'Senha',
          obscureText: _obscureText,
          enabled: !userManager.isLoading,
          controller: context.findAncestorStateOfType<_LoginScreenState>()?._passwordController,
          suffixIcon: _obscureText ? MyIcons.eyeOff : MyIcons.eyeOn,
          suffixOnTap: () => obscureText = !_obscureText,
          validator: (password) {
            if (password == null || password.isEmpty || password.length < 6) {
              return 'Senha inválida';
            }
            return null;
          },
        ),
      );
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
        builder: (_, userManager, __) => SubmitFormButton(
          text: 'Entrar',
          isLoading: userManager.isLoading,
          onPressed: userManager.isLoading ? null : onPressed,
        ),
      );
}
