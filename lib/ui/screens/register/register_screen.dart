import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';
import 'package:lojavirtualapp/ui/common/custom_form_field/custom_form_field.dart';
import 'package:lojavirtualapp/ui/common/submit_form_button.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:lojavirtualapp/utils/validators.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  UserModel _user = const UserModel();

  set user(UserModel user) => _user = user;

  void _createUser() {
    context.read<UserManager>().signUp(
          user: _user,
          onFail: (error) => customSnackbar(
            context,
            message: error,
            type: AnimatedSnackBarType.error,
          ),
          onSuccess: () => context.pushReplacement(AppRoutes.base),
        );
  }

  void _formSubmitted() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_user.password != _user.confirmPassword) {
        customSnackbar(
          context,
          message: 'As senha não coincidem!',
          type: AnimatedSnackBarType.warning,
        );
      } else {
        _createUser();
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Criar conta'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  const _FullName(),
                  const Gap(16),

                  /// E-mail
                  const _Email(),
                  const Gap(16),

                  /// Senha
                  const _Password(),
                  const Gap(16),

                  /// Confirmar senha
                  const _ConfirmPassword(),
                  const Gap(16),

                  /// Submit form
                  _SubmitForm(_formSubmitted),
                ],
              ),
            ),
          ),
        ),
      );
}

class _FullName extends StatelessWidget {
  const _FullName();

  @override
  Widget build(BuildContext context) {
    final ancestorState = context.findAncestorStateOfType<_RegisterScreenState>();

    return Consumer<UserManager>(
      builder: (_, userManager, __) => CustomFormField(
        hintText: 'Nome completo',
        enabled: !userManager.isLoading,
        validator: (name) {
          if (name == null || name.isEmpty) {
            return 'Nome completo obrigatório';
          } else if (name.trim().split(' ').length <= 1) {
            return 'Nome completo inválido';
          }
          return null;
        },
        onSaved: (name) => ancestorState?.user = ancestorState._user.copyWith(fullName: name),
      ),
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    final ancestorState = context.findAncestorStateOfType<_RegisterScreenState>();

    return Consumer<UserManager>(
      builder: (_, userManager, __) => CustomFormField(
        hintText: 'E-mail',
        enabled: !userManager.isLoading,
        keyboardType: TextInputType.emailAddress,
        validator: (email) {
          if (email == null || email.isEmpty) {
            return 'E-mail obrigatório';
          } else if (!emailValid(email)) {
            return 'E-mail inválido';
          }
          return null;
        },
        onSaved: (email) => ancestorState?.user = ancestorState._user.copyWith(email: email),
      ),
    );
  }
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
  Widget build(BuildContext context) {
    final ancestorState = context.findAncestorStateOfType<_RegisterScreenState>();

    return Consumer<UserManager>(
      builder: (_, userManager, __) => CustomFormField(
        hintText: 'Senha',
        enabled: !userManager.isLoading,
        obscureText: _obscureText,
        suffixIcon: _obscureText ? MyIcons.eyeOff : MyIcons.eyeOn,
        suffixOnTap: () => obscureText = !_obscureText,
        validator: (password) {
          if (password == null || password.isEmpty) {
            return 'Senha obrigatória';
          } else if (password.length < 6) {
            return 'Sua senha deve conter pelo menos 6 caracteres';
          }
          return null;
        },
        onSaved: (password) => ancestorState?.user = ancestorState._user.copyWith(password: password),
      ),
    );
  }
}

class _ConfirmPassword extends StatelessWidget {
  const _ConfirmPassword();

  @override
  Widget build(BuildContext context) {
    final ancestorState = context.findAncestorStateOfType<_RegisterScreenState>();

    return Consumer<UserManager>(
      builder: (_, userManager, __) => CustomFormField(
        obscureText: true,
        enabled: !userManager.isLoading,
        hintText: 'Confirme a senha',
        validator: (password) {
          if (password == null || password.isEmpty || password.length < 6) {
            return 'As senha não coincidem';
          }
          return null;
        },
        onSaved: (password) => ancestorState?.user = ancestorState._user.copyWith(confirmPassword: password),
      ),
    );
  }
}

class _SubmitForm extends StatelessWidget {
  const _SubmitForm(this.onPressed);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Consumer<UserManager>(
        builder: (_, userManager, __) => SubmitFormButton(
          text: 'Criar conta',
          isLoading: userManager.isLoading,
          onPressed: userManager.isLoading ? null : onPressed,
        ),
      );
}
