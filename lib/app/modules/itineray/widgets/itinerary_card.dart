import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/models/itinerary.dart';
import 'package:transporte_escolar/app/models/school.dart';
import 'package:transporte_escolar/app/providers/itinerary/itinerary_provider.dart';
import 'package:transporte_escolar/app/providers/school/school_provider.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class ItineraryCard extends StatelessWidget {
  const ItineraryCard({
    super.key,
    required this.itinerary,
    required this.itineraryProvider,
    required this.appUserProvider,
    required this.schoolProvider,
  });
  final Itinerary itinerary;
  final ItineraryProvider itineraryProvider;
  final AppUserProvider appUserProvider;
  final SchoolProvider schoolProvider;

  @override
  Widget build(BuildContext context) {
    final school = ModalRoute.of(context)?.settings.arguments as School?;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/itinerarydetail',
          arguments: itinerary,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.deepPurple, width: 1),
        ),
        child: ListTile(
          title: Text(itinerary.code),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: appUserProvider.appUser?.userType != 'admin' &&
                    school?.id != null
                ? [
                    IconButton(
                      onPressed: () async {
                        if (school != null) {
                          await schoolProvider.addItineraryToSchool(
                              itinerary.id!, school.id!);
                          await itineraryProvider.addSchoolToItinerary(
                              itinerary.id!, school.id!);
                          // ignore: use_build_context_synchronously
                          Messages.of(context).showInfo(
                              'Itinerário ${itinerary.code} adicionado à escola ${school.name} com sucesso!');
                        } else {
                          Messages.of(context)
                              .showError('Escola não encontrada!');
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.deepPurple,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (school != null) {
                          await schoolProvider.removeItineraryFromSchool(
                              itinerary.id!, school.id!);
                          await itineraryProvider.removeSchoolFromItinerary(
                              itinerary.id!, school.id!);

                          // ignore: use_build_context_synchronously
                          Messages.of(context).showInfo(
                              'Itinerário ${itinerary.code} removido da escola ${school.name} com sucesso!');
                        } else {
                          Messages.of(context)
                              .showError('Escola não encontrada!');
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () async {
                        if (school != null) {
                          await schoolProvider.addItineraryToSchool(
                              itinerary.id!, school.id!);
                          await itineraryProvider.addSchoolToItinerary(
                              itinerary.id!, school.id!);
                          // ignore: use_build_context_synchronously
                          Messages.of(context).showInfo(
                              'Itinerário ${itinerary.code} adicionado à escola ${school.name} com sucesso!');
                        } else {
                          Messages.of(context)
                              .showError('Escola não encontrada!');
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.deepPurple,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (school != null) {
                          await schoolProvider.removeItineraryFromSchool(
                              itinerary.id!, school.id!);
                          await itineraryProvider.removeSchoolFromItinerary(
                              itinerary.id!, school.id!);

                          // ignore: use_build_context_synchronously
                          Messages.of(context).showInfo(
                              'Itinerário ${itinerary.code} removido da escola ${school.name} com sucesso!');
                        } else {
                          Messages.of(context)
                              .showError('Escola não encontrada!');
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/itineraryedit',
                          arguments: itinerary,
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.deepPurple,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Excluir itinerário'),
                              content: const Text(
                                  'Tem certeza que deseja excluir este itinerário?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                    onPressed: () {
                                      itineraryProvider.deleteitinerary(
                                          itineraryId: itinerary.id!);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Excluir')),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
