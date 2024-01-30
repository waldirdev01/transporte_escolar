import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/constants.dart';
import 'package:transporte_escolar/app/core/ui/app_bar.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/core/widgets/app_logo.dart';
import '../../models/school.dart';

class SchoolDetailsPage extends StatelessWidget {
  const SchoolDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final school = ModalRoute.of(context)!.settings.arguments as School;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Dados da Escola'),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/itinerarieslist',
            arguments: school,
          );
        },
        label: const Text(
          'Adicionar Itinerário à Escola',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
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
                onPressed: () {},
                child: const Text('Adicionar Aluno',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/itinerariesBySchool',
                    arguments: school,
                  );
                },
                child: const Text('Ver itinerários da escola',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Constants.schoolMembersList,
                    arguments: school,
                  );
                },
                child: const Text('Adcionar Usuário à Escola',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
