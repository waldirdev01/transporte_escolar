import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/app_bar.dart';
import 'package:transporte_escolar/app/core/ui/messages.dart';
import 'package:transporte_escolar/app/models/app_user.dart';
import 'package:transporte_escolar/app/models/school.dart';
import 'package:transporte_escolar/app/modules/users/school_member/widgets/school_member_card_list.dart';
import 'package:transporte_escolar/app/providers/school/school_provider.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class SchoolMembersList extends StatelessWidget {
  const SchoolMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    School school = ModalRoute.of(context)!.settings.arguments as School;
    return Scaffold(
        appBar: const CustomAppBar(title: 'Selecionar usuário da Escola'),
        body: FutureBuilder(
            future: context
                .watch<AppUserProvider>()
                .getAppUsersByType('schoolMember'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Caso esteja carregando os dados, você pode exibir um indicador de progresso.
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Caso ocorra um erro durante o carregamento dos dados.
                return Center(
                  child: Text('Erro ao carregar usuários: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Caso não haja dados ou os dados estejam vazios.
                return const Center(
                    child: Text('Nenhum usuário cadastrado',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)));
              } else {
                // Caso os dados tenham sido carregados com sucesso.
                final users = snapshot.data!;
                users.sort((a, b) => a.name.compareTo(b.name));

                return Consumer<SchoolProvider>(
                    builder: (context, provider, child) {
                  provider.getSchool(school.id!);
                  school = provider.school ?? school;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final appUser = users[index];
                      bool isSelectede = school.appUserId!.contains(appUser.id);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SchoolMemberCardList(
                          isSelected: isSelectede,
                          appUser: appUser,
                          school: school,
                          addMemberSchool: () async {
                            await addMemberSchool(appUser, school,
                                context: context);

                            isSelectede = true;
                          },
                          removeMemberSchool: () async {
                            await removeUserFromSchool(appUser, school,
                                context: context);
                            isSelectede = false;
                          },
                        ),
                      );
                    },
                  );
                });
              }
            }));
  }

  Future<void> addMemberSchool(AppUser appUser, School school,
      {BuildContext? context}) {
    try {
      SchoolProvider().addUserToSchool(appUser.id, school.id!);
      Messages.of(context!).showInfo(
          'Usuário ${appUser.name} adicionado à escola ${school.name} com sucesso!');
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      Messages.of(context!).showError('Erro ao adicionar usuário à escola');
    }
    return Future.value();
  }

  Future<void> removeUserFromSchool(AppUser appUser, School school,
      {BuildContext? context}) {
    try {
      SchoolProvider().removeUserFromSchool(appUser.id, school.id!);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    return Future.value();
  }
}
