// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/core/widgets/app_field.dart';
import 'package:transporte_escolar/app/providers/school/school_provider.dart';
import 'package:validatorless/validatorless.dart';
import '../../models/school.dart';

class SchoolCreateForm extends StatefulWidget {
  const SchoolCreateForm({super.key});

  @override
  _SchoolCreateFormState createState() => _SchoolCreateFormState();
}

class _SchoolCreateFormState extends State<SchoolCreateForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _nameEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _inepEC = TextEditingController();
  final _principalNameEC = TextEditingController();
  final _principalRegisterEC = TextEditingController();
  final _secretaryNameEC = TextEditingController();
  final _secretaryRegisterEC = TextEditingController();
  String _typeSchool = 'URBANA';
  late SchoolProvider _schoolProvider;
  @override
  void initState() {
    super.initState();
    _schoolProvider = SchoolProvider();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _phoneEC.dispose();
    _inepEC.dispose();
    _principalNameEC.dispose();
    _principalRegisterEC.dispose();
    _secretaryNameEC.dispose();
    _secretaryRegisterEC.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      try {
        final school = School(
            name: _nameEC.text,
            phone: _phoneEC.text,
            inep: _inepEC.text,
            principalName: _principalNameEC.text,
            principalRegister: _principalRegisterEC.text,
            secretaryName: _secretaryNameEC.text,
            secretaryRegister: _secretaryRegisterEC.text,
            type: _typeSchool,
            studentsId: []);
        setState(() {
          _isLoading = true;
        });
        await _schoolProvider.createSchool(school: school);
        Messages.of(context).showInfo('Escola criada com sucesso');
      } on FirebaseException catch (e) {
        Messages.of(context).showError('Erro ao criar escola $e');
      } finally {
        setState(() {
          _isLoading = false;
        });

        setState(() {
          _inepEC.clear();
          _nameEC.clear();
          _phoneEC.clear();
          _principalNameEC.clear();
          _principalRegisterEC.clear();
          _secretaryNameEC.clear();
          _secretaryRegisterEC.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Escola'),
        iconTheme: context.iconThemeCustom,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppField(
                label: 'nome',
                controller: _nameEC,
                validator: Validatorless.required('O nome é obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'telefone',
                controller: _phoneEC,
                validator: Validatorless.required('O telefone é obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'inep',
                controller: _inepEC,
                validator: Validatorless.required('O inep é obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'nome do diretor',
                controller: _principalNameEC,
                validator:
                    Validatorless.required('O nome do diretor é obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'matrícula do diretor',
                controller: _principalRegisterEC,
                validator: Validatorless.required(
                    'A matrícula do diretor é obrigatória'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'nome do secretário',
                controller: _secretaryNameEC,
                validator: Validatorless.required(
                    'O nome do secretário é obrigatório'),
              ),
              const SizedBox(
                height: 10,
              ),
              AppField(
                label: 'matrícula do secretário',
                controller: _secretaryRegisterEC,
                validator: Validatorless.required(
                    'A matrícula do secretário é obrigatória'),
              ),
              const Divider(),
              DropdownButtonFormField<String>(
                value: _typeSchool,
                onChanged: (value) {
                  setState(() {
                    _typeSchool = value!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'URBANA',
                    child: Text('URBANA'),
                  ),
                  DropdownMenuItem(
                    value: 'RURAL',
                    child: Text('RURAL'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: _isLoading ? null : _submitForm,
                child: const Text('Adicionar Escola',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
