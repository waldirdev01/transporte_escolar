import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/modules/itineray/widgets/itinerary_card.dart';

import '../../models/itinerary.dart';
import '../../providers/itinerary/itinerary_provider.dart';

class ItineriesList extends StatelessWidget {
  const ItineriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Itinerários cadastrados',
          style: context.titleStyle,
        ),
        iconTheme: context.iconThemeCustom,
      ),
      body: FutureBuilder<List<Itinerary>>(
        future: context.read<ItineraryProvider>().getitineraries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Caso esteja carregando os dados, você pode exibir um indicador de progresso.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Caso ocorra um erro durante o carregamento dos dados.
            return Center(
              child: Text('Erro ao carregar itinerários: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados ou os dados estejam vazios.
            return const Center(
              child: Text('Nenhum itinerário cadastrado'),
            );
          } else {
            // Caso os dados tenham sido carregados com sucesso.
            final itineraries = snapshot.data!;
            return ListView.builder(
              itemCount: itineraries.length,
              itemBuilder: (context, index) {
                final itinerary = itineraries[index];
                return ItineraryCard(
                  itinerary: itinerary,
                  edit: () {
                    Navigator.pushNamed(context, '/itineraryedit',
                        arguments: itinerary);
                  },
                  delete: () {},
                  navigator: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
