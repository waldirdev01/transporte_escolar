import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import '../../../models/app_user.dart';
import '../../../models/school.dart';
import '../../../providers/school/school_provider.dart';
import '../../../providers/user/app_user_provider.dart';

class SchoolCardList extends StatelessWidget {
  const SchoolCardList({
    super.key,
    required this.school,
    required this.schoolProvider,
    required this.userProvider,
  });

  final School school;
  final SchoolProvider schoolProvider;
  final AppUserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: context.primaryColor,
      child: ListTile(
        title: Text(school.name),
        subtitle: Text(school.phone),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: userProvider.appUser?.userType != UserType.admin.string
              ? []
              : [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: context.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/schooledit',
                        arguments: school,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Excluir escola'),
                            content: const Text(
                                'Tem certeza que deseja excluir esta escola?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Excluir'),
                                onPressed: () {
                                  schoolProvider.deleteSchool(
                                      schoolId: school.id!);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
        ),
      ),
    );
  }
}
