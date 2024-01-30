import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';
import 'package:transporte_escolar/app/providers/school/school_provider.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class SchoolsBySchoolMember extends StatelessWidget {
  const SchoolsBySchoolMember({super.key});

  @override
  Widget build(BuildContext context) {
    final appUserProvider = context.read<AppUserProvider>();
    final appUser = appUserProvider.appUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Escolas',
        ),
        iconTheme: context.iconThemeCustom,
        actions: [
          IconButton(
            onPressed: () {
              appUserProvider.logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: FutureBuilder(
          future: context
              .read<SchoolProvider>()
              .getSchoolBySchoolMember(appUser!.id),
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar escolas: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Você não está vinculado a nenhuma escola!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              final schools = snapshot.data!;
              return ListView.builder(
                itemCount: schools.length,
                itemBuilder: (context, index) {
                  final school = schools[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Colors.deepPurple, width: 1),
                    ),
                    child: ListTile(
                      title: Text(school.name),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/schooldetails',
                            arguments: school,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
