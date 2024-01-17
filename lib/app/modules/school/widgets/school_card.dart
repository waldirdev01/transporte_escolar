import 'package:flutter/material.dart';

import '../../../models/school.dart';

class SchoolCard extends StatelessWidget {
  final School school;
  final bool selected;
  final VoidCallback? onAddPressed;
  final VoidCallback? onRemovePressed;

  const SchoolCard({
    Key? key,
    required this.school,
    this.selected = false,
    this.onAddPressed,
    this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.deepPurple,
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: selected ? Colors.green[100] : null,
      child: ListTile(
        title: Text(school.name),
        subtitle: Text(
            'Telefone: ${school.phone} | Diretor: ${school.principalName}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onAddPressed != null && !selected)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onAddPressed,
              ),
            if (onRemovePressed != null && selected)
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onRemovePressed,
              ),
          ],
        ),
      ),
    );
  }
}
