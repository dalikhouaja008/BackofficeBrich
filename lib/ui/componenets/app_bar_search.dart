
//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
class CustomAppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarSearch({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        width: 400,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher...',
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://ui-avatars.com/api/?name=Admin+User',
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
