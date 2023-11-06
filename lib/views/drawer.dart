import 'package:flutter/material.dart';
import 'package:netwin_test/views/hotel_list_screen.dart';
import 'package:netwin_test/views/map_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // DrawerHeader(child: Text(projectName, style: TextStyle(),)),
            DrawerMenu(
              icon: const Icon(Icons.hotel),
              title: "Hotel List",
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HotelListScreen(),
                ));
              },
            ),
            DrawerMenu(
              icon: const Icon(Icons.map),
              title: "Map",
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ));
              },
            ),
            // DrawerMenu(title: "Hotel List"),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final String title;
  final Widget? icon;
  final void Function()? onTap;
  const DrawerMenu({super.key, required this.title, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        leading: icon,
      ),
    );
  }
}
