import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';
import '../../models/school.dart';
import '../../providers/school/school_provider.dart';
import 'widgets/school_card_list.dart';

class SchoolList extends StatelessWidget {
  const SchoolList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolas'),
        iconTheme: context.iconThemeCustom,
      ),
      body: FutureBuilder<List<School>>(
        future: context.watch<SchoolProvider>().getSchools(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Caso esteja carregando os dados, você pode exibir um indicador de progresso.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Caso ocorra um erro durante o carregamento dos dados.
            return Center(
              child: Text('Erro ao carregar escolas: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados ou os dados estejam vazios.
            return Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/bus.jpg'),
                    const SizedBox(height: 20),
                    const Text(
                      'Nenhuma escola cadastrada',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Caso os dados tenham sido carregados com sucesso.
            final schools = snapshot.data!;
            return ListView.builder(
              itemCount: schools.length,
              itemBuilder: (context, index) {
                final school = schools[index];
                return InkWell(
                  child: SchoolCardList(
                    school: school,
                    schoolProvider: context.read<SchoolProvider>(),
                    userProvider: context.read<AppUserProvider>(),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/schooldetails',
                      arguments: school,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
