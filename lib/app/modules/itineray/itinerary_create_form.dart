// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/core/widgets/app_field.dart';
import 'package:transporte_escolar/app/providers/itinerary/itinerary_provider.dart';
import 'package:validatorless/validatorless.dart';
import '../../core/ui/messages.dart';
import '../../models/itinerary.dart';

class ItineraryCreateForm extends StatefulWidget {
  const ItineraryCreateForm({Key? key}) : super(key: key);

  @override
  _ItineraryCreateFormState createState() => _ItineraryCreateFormState();
}

class _ItineraryCreateFormState extends State<ItineraryCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _vehiclePlate = TextEditingController();
  final _driverName = TextEditingController();
  int _capacity = 0;
  final _driverLicence = TextEditingController();
  final _driverPhone = TextEditingController();
  String _shift = 'MATUTINO';
  double _kilometer = 0;
  final _kilometerEC = TextEditingController();
  final _capacityEC = TextEditingController();
  final _description = TextEditingController();
  final _contract = TextEditingController();
  final _annotation = TextEditingController();
  late ItineraryProvider _itineraryProvider;

  @override
  void initState() {
    super.initState();
    _itineraryProvider = ItineraryProvider();
  }

  @override
  void dispose() {
    _code.dispose();
    _vehiclePlate.dispose();
    _driverName.dispose();
    _driverLicence.dispose();
    _driverPhone.dispose();
    _description.dispose();
    _contract.dispose();
    _annotation.dispose();
    _capacityEC.dispose();
    _kilometerEC.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      try {
        final itinerary = Itinerary(
          code: _code.text,
          vehiclePlate: _vehiclePlate.text,
          driverName: _driverName.text,
          capacity: _capacity,
          driverLicence: _driverLicence.text,
          driverPhone: _driverPhone.text,
          shift: _shift,
          kilometer: _kilometer,
          description: _description.text,
          contract: _contract.text,
          importantAnnotation: _annotation.text,
        );
        setState(() {});
        await _itineraryProvider.createItinerary(itinerary: itinerary);
        Messages.of(context).showInfo('Itinerário criada com sucesso');
      } on FirebaseException catch (e) {
        Messages.of(context).showError('Erro ao criar itinerário $e');
      } finally {
        setState(() {
          _annotation.clear();
          _code.clear();
          _contract.clear();
          _description.clear();
          _driverLicence.clear();
          _driverName.clear();
          _driverPhone.clear();
          _vehiclePlate.clear();
          _kilometerEC.clear();
          _capacityEC.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Itinerário'),
        iconTheme: context.iconThemeCustom,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _code,
                decoration: InputDecoration(
                    labelText: 'Código',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onSaved: (value) {
                  _code.text = value ?? '';
                },
                validator: Validatorless.required('Informe o código'),
              ),
              const SizedBox(height: 20),
              AppField(
                label: 'Placa do Veículo',
                controller: _vehiclePlate,
                validator: Validatorless.required('Informe a placa do veículo'),
              ),
              const SizedBox(height: 20),
              AppField(
                label: 'Nome do Motorista',
                controller: _driverName,
                validator:
                    Validatorless.required('Informe o nome do motorista'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _capacityEC,
                decoration: InputDecoration(
                    labelText: 'Capacidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onSaved: (value) {
                  _capacity = int.tryParse(value ?? '')!;
                },
                validator: Validatorless.required('Informe a capacidade'),
              ),
              const SizedBox(height: 20),
              AppField(
                label: 'CNH',
                controller: _driverLicence,
                validator: Validatorless.required('Informe a CNH'),
              ),
              const SizedBox(height: 20),
              AppField(
                label: 'Telefone do Motorista',
                controller: _driverPhone,
                validator:
                    Validatorless.required('Informe o telefone do motorista'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _kilometerEC,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+(,\d{0,2})?$')),
                ],
                decoration: InputDecoration(
                    labelText: 'Quilometragem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onSaved: (value) {
                  final formattedValue = value?.replaceAll(',', '.');
                  _kilometer = double.tryParse(formattedValue ?? '')!;
                },
                validator: (value) {
                  if (value != null && value.contains('.')) {
                    return 'Use vírgula como separador decimal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Turno'),
                value: _shift,
                onChanged: (newValue) {
                  setState(() {
                    _shift = newValue as String;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'MATUTINO',
                    child: Text('MATUTINO'),
                  ),
                  DropdownMenuItem(
                    value: 'VESPERTINO',
                    child: Text('VESPERTINO'),
                  ),
                  DropdownMenuItem(
                    value: 'NOTURNO',
                    child: Text('NOTURNO'),
                  ),
                  DropdownMenuItem(
                    value: 'INTEGRAL',
                    child: Text('INTEGRAL'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: context.elevatedButtonThemeCustom,
                onPressed: _submitForm,
                child: const Text('Adicionar Itinerário',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
