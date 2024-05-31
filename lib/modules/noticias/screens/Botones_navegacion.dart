// bottom_nav_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/noticias/screens/agregar_noticia.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application_1/modules/noticias/screens/agregar_noticia.dart';

Widget buildBottomNavBar(BuildContext context) {
  return GNav(
    tabs: [
      GButton(
        icon: Icons.home,
        text: 'Home',
        onPressed: () {
        },
      ),
      GButton(
        icon: Icons.add,
        text: 'Agregar',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoticia()),
          );
        },
      ),
    ],
  );
}

