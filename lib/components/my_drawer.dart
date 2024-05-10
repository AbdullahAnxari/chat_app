import 'package:flutter/material.dart';
import 'package:flutter_chat_application/lib.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      final authServices = AuthServices();
      authServices.signOut();

      Get.offAll(() => const AuthGate());
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
          ),
          //home list  tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Get.back(),
              title: const Text('H O M E'),
            ),
          ),
          //setting list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Get.to(() => const SettingPage()),
              title: const Text('S E T T I N G'),
            ),
          ),
          //logout list tile
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                logout();
              },
              title: const Text('L O G O U T'),
            ),
          ),
        ],
      ),
    );
  }
}
