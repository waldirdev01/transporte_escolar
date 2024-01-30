import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/widgets/app_logo.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRANSPORTE ESCOLAR',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const AppLogo(),
              const Text('Usuário cadastrado com sucesso!'),
              const SizedBox(height: 20),
              const Text('Aguarde a aprovação do administrador.'),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  },
                  child: const Text('Voltar ao login')),
            ],
          ),
        ),
      ),
    );
  }
}
