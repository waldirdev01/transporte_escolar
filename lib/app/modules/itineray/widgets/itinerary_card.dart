import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/itinerary.dart';

class ItineraryCard extends StatelessWidget {
  const ItineraryCard(
      {super.key,
      required this.itinerary,
      required this.edit,
      required this.delete,
      required this.navigator});
  final Itinerary itinerary;
  final Function()? edit;
  final Function()? delete;
  final Function()? navigator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigator,
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
            children: [
              IconButton(
                onPressed: edit,
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
                              onPressed: delete, child: const Text('Excluir')),
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
