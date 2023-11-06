import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color color;
  const Menu(
      {super.key,
      required this.title,
      required this.children,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        children: children,
      ),
    );
  }
}
