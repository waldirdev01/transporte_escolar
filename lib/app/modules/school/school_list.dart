import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/school/school_provider.dart';

class SchoolList extends StatelessWidget {
  const SchoolList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Escolas'),
        ),
        body: Consumer<SchoolProvider>(
          builder: (context, provider, child) {
            provider.getSchools();
            if (provider.schools.isEmpty) {
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

            final schools = provider.schools;
            return ListView.builder(
              itemCount: schools.length,
              itemBuilder: (context, index) {
                final school = schools[index];
                return ListTile(
                  title: Text(school.name),
                  subtitle: Text(school.phone),
                  onTap: () {
                    Navigator.pushNamed(context, '/schooldetails',
                        arguments: school);
                  },
                );
              },
            );
          },
        ));
  }
}
