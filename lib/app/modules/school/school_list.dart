import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';
import '../../providers/school/school_provider.dart';
import 'widgets/school_card_list.dart';

class SchoolList extends StatelessWidget {
  const SchoolList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Escolas'),
        ),
        body: Consumer2<SchoolProvider, AppUserProvider>(
          builder: (context, schoolProvider, userProvider, child) {
            schoolProvider.getSchools();
            if (schoolProvider.schools.isEmpty) {
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
            }

            final schools = schoolProvider.schools;
            return ListView.builder(
              itemCount: schools.length,
              itemBuilder: (context, index) {
                final school = schools[index];
                return InkWell(
                    child: SchoolCardList(
                      school: school,
                      schoolProvider: schoolProvider,
                      userProvider: userProvider,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/schooldetails',
                        arguments: school,
                      );
                    });
              },
            );
          },
        ));
  }
}
