import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/app_user.dart';
import 'package:transporte_escolar/app/models/school.dart';

class SchoolMemberCardList extends StatelessWidget {
   SchoolMemberCardList(
      {super.key,
      required this.appUser,
      required this.school,
      this.addMemberSchool,
      this.removeMemberSchool, required this.isSelected});
  final AppUser appUser;
  final School school;
  final Function()? addMemberSchool;
  final Function()? removeMemberSchool;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected
          ? Colors.green[100]
          : Colors.white,
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${appUser.name}'),
                Text('Email: ${appUser.email}'),
                Text('Telefone: ${appUser.phone}')
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            IconButton(onPressed: addMemberSchool, icon: const Icon(Icons.add)),
            IconButton(
                onPressed: removeMemberSchool, icon: const Icon(Icons.remove)),
          ],
        ),
      ),
    );
  }

  
}
