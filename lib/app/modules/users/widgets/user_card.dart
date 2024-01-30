import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/app_user.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.appUser,
    required this.appUserProvider,
  }) : super(key: key);

  final AppUser appUser;
  final AppUserProvider appUserProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(appUser.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appUser.email),
                  Text(appUser.phone),
                  Text(appUser.userType.toUpperCase())
                ],
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(Icons.admin_panel_settings, 'admin', Colors.red),
              _buildIconButton(
                  Icons.manage_accounts, 'coordinator', Colors.green),
              _buildIconButton(Icons.school, 'schoolMember', Colors.blue),
              _buildIconButton(Icons.woman, 'monitor', Colors.orange),
              _buildIconButton(Icons.bus_alert, 'tcb', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String userType, Color color) {
    return IconButton(
      onPressed: () {
        appUserProvider.updateUserType(
            appUserId: appUser.id, appUserType: userType);
      },
      icon:
          Icon(icon, color: appUser.userType == userType ? color : Colors.grey),
    );
  }
}
