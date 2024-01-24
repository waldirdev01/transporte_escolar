// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/core/widgets/app_field.dart';
import 'package:transporte_escolar/app/core/widgets/app_logo.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/messages.dart';
import '../../../providers/user/app_user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();
  bool isLoading = false;
  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('POLLO', style: TextStyle(color: Colors.white)),
        ),
        body: LayoutBuilder(
          builder: ((context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.minWidth),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const AppLogo(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              AppField(
                                label: 'E-mail',
                                controller: _emailEC,
                                focusNode: _emailFocus,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Email obrigatório'),
                                  Validatorless.email('E-mail inválido'),
                                ]),
                              ),
                              const SizedBox(height: 20),
                              AppField(
                                label: 'Senha',
                                obscureText: true,
                                controller: _passwordEC,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Senha obrigatório'),
                                  Validatorless.min(6,
                                      'Senha deve conter pelo menos 6 caracteres'),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (_emailEC.text.isNotEmpty) {
                                      } else {
                                        _emailFocus.requestFocus();
                                        Messages.of(context).showError(
                                            'Digite um e-mail para recuperar sua senha');
                                      }
                                    },
                                    child: Text(
                                      'Esqueceu sua senha?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: context.primaryColor),
                                    ),
                                  ),
                                  Consumer<AppUserProvider>(
                                    builder: (context, provider, child) {
                                      return ElevatedButton(
                                          onPressed: isLoading
                                              ? null
                                              : () => _login(provider),
                                          style:
                                              context.elevatedButtonThemeCustom,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Login',
                                              style: context.buttonText,
                                            ),
                                          ));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0F3F7),
                                  border: Border(
                                      top: BorderSide(
                                    width: 2,
                                    color: Colors.grey.withAlpha(50),
                                  )),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text('Não tem conta',
                                            style: TextStyle(fontSize: 18)),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('/register');
                                          },
                                          child: Text('Cadastre-se',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: context.primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }

  void _login(AppUserProvider provider) async {
    final formValid = _formkey.currentState?.validate() ?? false;
    setState(() {
      isLoading = true;
    });
    if (formValid) {
      final email = _emailEC.text;
      final password = _passwordEC.text;
      try {
        await provider.login(email, password);
        final user = provider.appUser;
        if (user != null) {
          Navigator.of(context).pushReplacementNamed('/userrouteprofile');
        } else {
          Messages.of(context)
              .showError('Usuário ou senha inválidos ou não cadastrado');
        }
      } on FirebaseAuthException {
        Messages.of(context).showError('Usuário ou senha inválidos');
      } catch (e) {
        Messages.of(context).showError(e.toString());
      }
    }
  }
}
