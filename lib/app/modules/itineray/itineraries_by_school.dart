// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/models/itinerary.dart';
import 'package:transporte_escolar/app/models/school.dart';
import 'package:transporte_escolar/app/providers/itinerary/itinerary_provider.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';
import 'widgets/itinerary_card.dart';

class ItinerariesBySchool extends StatelessWidget {
  const ItinerariesBySchool({super.key});

  @override
  Widget build(BuildContext context) {
    final School school = ModalRoute.of(context)!.settings.arguments as School;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Itinerários cadastrados',
          style: context.titleStyle,
        ),
        iconTheme: context.iconThemeCustom,
      ),
      body: FutureBuilder<List<Itinerary>>(
          future: context
              .read<ItineraryProvider>()
              .getItinerariesForSchool(school.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              Messages.of(context).showError(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Nenhum itinerário cadastrado'),
              );
            } else {
              final itineraries = snapshot.data!;
              return ListView.builder(
                itemCount: itineraries.length,
                itemBuilder: (context, index) {
                  final itinerary = itineraries[index];
                  if (itinerary.schoolIds!.contains(school.id)) {
                    return ItineraryCard(
                        itinerary: itinerary,
                        itineraryProvider: context.read<ItineraryProvider>(),
                        appUserProvider: context.read<AppUserProvider>());
                  } else {
                    return Column(
                      children: [
                        Container(
                          height: 300,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bus.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 100),
                        ),
                        const Text(
                          'Nenhum itinerário encontrado.',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                },
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
