import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_card.dart';
import '../../providers/user/app_user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POLLO'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppUserProvider>().logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
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
                Navigator.pushNamed(context, '/schoolcreate');
              },
            ),
            CustomCard(
              icon: Icons.list_alt,
              text: 'Todas as Escolas',
              onTap: () {
                Navigator.pushNamed(context, '/schoollist');
              },
            ),
            CustomCard(
              icon: Icons.route,
              text: 'Cadastrar Itinerário',
              onTap: () {
                debugPrint('Cadastrar Itinerário Pressionado');
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateItineraryScreen(),
                  ),
                );*/
              },
            ),
            CustomCard(
              icon: Icons.list_alt,
              text: 'Todos os Itinerários',
              onTap: () {
                /*debugPrint('Todos os Itinerários Pressionado');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ItineraryList(),
                  ),
                );*/
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
            CustomCard(
              icon: Icons.group,
              text: 'Novos usuários',
              onTap: () {
                /*debugPrint('Novos usuários Pressionado');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewUsersList(),
                  ),
                );*/
              },
            ),
            CustomCard(
                icon: Icons.info,
                text: 'Gerenciar Usuários',
                onTap:
                    () {} /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AppUserList())),*/
                ),
          ],
        ),
      ),
    );
  }
}
