import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/core/widgets/app_logo.dart';
import '../../models/school.dart';

class SchoolDetailsPage extends StatefulWidget {
  const SchoolDetailsPage({Key? key}) : super(key: key);

  @override
  State<SchoolDetailsPage> createState() => _SchoolDetailScreenState();
}

class _SchoolDetailScreenState extends State<SchoolDetailsPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final school = ModalRoute.of(context)!.settings.arguments as School;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da Escola',
        ),
        iconTheme: context.iconThemeCustom,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(alignment: Alignment.bottomCenter, child: AppLogo()),
              const SizedBox(height: 16),
              Text(
                school.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, color: context.primaryColor),
                  const SizedBox(width: 8),
                  Text(school.phone),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: context.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  const Text(
                    'Equipe Escolar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: context.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(school.principalName),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: context.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(school.secretaryName),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              Text(
                'Código Inep: ${school.inep}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                },
                child: const Text('Adicionar Aluno',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                      },
                child: const Text('Ver itinerários da escola',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
