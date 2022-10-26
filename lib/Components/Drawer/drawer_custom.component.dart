import 'package:burguer/Components/Drawer/options_drawer.component.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatefulWidget {
  final bool admin;
  const DrawerCustom({
    Key? key,
    required this.admin,
  }) : super(key: key);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  AuthenticationService auth = AuthenticationService();

  _logOut(context) {
    auth.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Expanded(
            child: OptionsDrawer(admin: widget.admin,)
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Deslogar ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Icon(
                  Icons.logout_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ],
            ),
            onTap: () {
              _logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
