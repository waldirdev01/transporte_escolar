import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import '../../models/school.dart';
import '../../providers/school/school_provider.dart';

class SchoolEditForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SchoolEditForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final schoolEdit = ModalRoute.of(context)!.settings.arguments as School;
    return Scaffold(
        appBar: AppBar(title: const Text('Editar Escola')),
        body: Consumer<SchoolProvider>(builder: (context, provider, child) {
          provider.getSchool(schoolEdit.id!);
          final school = provider.school;
          if (school != null) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Nome da escola'),
                      initialValue: school.name,
                      onSaved: (value) => school.name = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      initialValue: school.phone,
                      onSaved: (value) => school.phone = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Nome do(a) diretor(a)'),
                      initialValue: school.principalName,
                      onSaved: (value) => school.principalName = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Matrícula do(a) diretor(a)'),
                      initialValue: school.principalRegister,
                      onSaved: (value) => school.principalRegister = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Nome do(a) secretário(a) escolar'),
                      initialValue: school.secretaryName,
                      onSaved: (value) => school.secretaryName = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Matrícula do(a) secretário(a) escolar'),
                      initialValue: school.secretaryRegister,
                      onSaved: (value) => school.secretaryRegister = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Código Inep'),
                      initialValue: school.inep,
                      onSaved: (value) => school.inep = value!,
                    ),
                    const Divider(),
                    ElevatedButton(
                      style: context.elevatedButtonThemeCustom,
                      onPressed: provider.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                provider.updateSchool(school: school);
                                Messages.of(context)
                                    .showInfo('Escola atualizada com sucesso');
                                Navigator.of(context).pop();
                              }
                            },
                      child: const Text('Salvar',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            const Text('Erro ao carregar escola',
                style: TextStyle(color: Colors.red));
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
