import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/providers/itinerary/itinerary_provider.dart';

import '../../models/itinerary.dart';

class ItineraryEditForm extends StatefulWidget {
  const ItineraryEditForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ItineraryEditFormState createState() => _ItineraryEditFormState();
}

class _ItineraryEditFormState extends State<ItineraryEditForm> {
  final _formKey = GlobalKey<FormState>();
  String _code = '';
  String _vehiclePlate = '';
  String _driverName = '';
  int _capacity = 0;
  String _driverLicence = '';
  String _driverPhone = '';
  String _shift = 'MATUTINO';
  double _kilometer = 0;
  String _description = '';
  String _contract = '';

  String _annotation = '';

  @override
  void initState() {
    super.initState();
  }

  void _submitForm(
      Itinerary itinerary, ItineraryProvider itineraryProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      itinerary.code = _code;
      itinerary.vehiclePlate = _vehiclePlate;
      itinerary.driverName = _driverName;
      itinerary.capacity = _capacity;
      itinerary.driverLicence = _driverLicence;
      itinerary.driverPhone = _driverPhone;
      itinerary.shift = _shift;
      itinerary.kilometer = _kilometer;
      itinerary.description = _description;
      itinerary.contract = _contract;
      itinerary.importantAnnotation = _annotation;
      await itineraryProvider.updateitinerary(itinerary: itinerary);
      // ignore: use_build_context_synchronously
      Messages.of(context).showInfo('Itinerário atualziado com sucesso');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itineraryEdit =
        ModalRoute.of(context)!.settings.arguments as Itinerary;
    return Scaffold(
        appBar: AppBar(title: const Text('Editar Itinerário')),
        body: Consumer<ItineraryProvider>(builder: (context, provider, child) {
          provider.getitinerary(itineraryEdit.id!);
          final itinerary = provider.itinerary;
          if (itinerary != null) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Itinerário'),
                      initialValue: itinerary.code,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O código é obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) => _code = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Placa do ônibus'),
                      initialValue: itinerary.vehiclePlate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A placa é obrigatória';
                        }
                        return null;
                      },
                      onSaved: (value) => _vehiclePlate = value!,
                    ),
                    const Divider(),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Nome do motorista'),
                      initialValue: itinerary.driverName,
                      onSaved: (value) => _driverName = value ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Capacidade do ônibus'),
                      initialValue: itinerary.capacity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A capacidade é obrigatória';
                        }
                        return null;
                      },
                      onSaved: (value) => _capacity = int.parse(value!),
                    ),
                    const Divider(),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'CNH do motorista'),
                      initialValue: itinerary.driverLicence,
                      onSaved: (value) => _driverLicence = value ?? '',
                    ),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Telefone do motorista'),
                      initialValue: itinerary.driverPhone,
                      onSaved: (value) => _driverPhone = value ?? '',
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(labelText: 'Turno'),
                      value: itinerary.shift,
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
                    TextFormField(
                      initialValue: itinerary.kilometer.toString(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+(,\d{0,2})?$')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Quilometragem',
                      ),
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
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      initialValue: itinerary.description,
                      onSaved: (value) => _description = value ?? '',
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contrato'),
                      initialValue: itinerary.contract,
                      onSaved: (value) => _contract = value ?? '',
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: itinerary.importantAnnotation,
                      decoration: const InputDecoration(
                          labelText: 'Anotações importantes'),
                      onSaved: (value) => _annotation = value ?? '',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: context.elevatedButtonThemeCustom,
                      onPressed: () => _submitForm(itinerary, provider),
                      child: const Text('Atualizar Itinerário',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
