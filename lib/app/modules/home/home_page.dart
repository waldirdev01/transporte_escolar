import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/constants.dart';
import '../../core/widgets/custom_card.dart';
import '../../providers/user/app_user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = context.watch<AppUserProvider>().appUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.comapanyName),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppUserProvider>().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Constants.loginRoute, (route) => false);
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            CustomCard(
              icon: Icons.account_balance,
              text: 'Cadastrar Escola',
              onTap: () {
                Navigator.pushNamed(context, Constants.schoolCreateRoute);
              },
            ),
            CustomCard(
              icon: Icons.list_alt,
              text: 'Todas as Escolas',
              onTap: () {
                Navigator.pushNamed(context, Constants.schoolListRoute);
              },
            ),
            CustomCard(
              icon: Icons.route,
              text: 'Cadastrar Itinerário',
              onTap: () {
                debugPrint('Cadastrar Itinerário Pressionado');
                Navigator.pushNamed(context, Constants.itineraryCreateRoute);
              },
            ),
            CustomCard(
              icon: Icons.list_alt,
              text: 'Todos os Itinerários',
              onTap: () {
                Navigator.pushNamed(context, Constants.itinerariesListRoute);
              },
            ),
            CustomCard(
              icon: Icons.school,
              text: 'Alunos pelo nome',
              onTap: () {
                /* debugPrint('Alunos pelo nome Pressionado');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentsByName(),
                  ),
                );*/
              },
            ),
            appUser?.userType != 'admin'
                ? const SizedBox()
                : CustomCard(
                    icon: Icons.manage_accounts,
                    text: 'Gerenciar Usuários',
                    onTap: () => Navigator.pushNamed(
                        context, Constants.managerUsersTypeRoute)),
          ],
        ),
      ),
    );
  }
}
// TODO parei em gerenciar usuários