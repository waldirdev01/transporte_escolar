import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/app_bar.dart';
import 'package:transporte_escolar/app/models/app_user.dart';
import 'package:transporte_escolar/app/modules/users/widgets/user_card.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class ManagerUsersType extends StatelessWidget {
  const ManagerUsersType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerenciar usuários'),
      body: FutureBuilder<List<AppUser>>(
          future: context.watch<AppUserProvider>().getAppUsers(),
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
                child: Text('Nenhum usuário cadastrado'),
              );
            } else {
              // Caso os dados tenham sido carregados com sucesso.
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final appUser = users[index];
                  return UserCard(
                    appUser: appUser,
                    appUserProvider: context.read<AppUserProvider>(),
                  );
                },
              );
            }
          }),
    );
  }
}
