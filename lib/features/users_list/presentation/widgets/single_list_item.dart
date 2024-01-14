import 'package:flutter/material.dart';

class SingleListItem extends StatelessWidget {
  const SingleListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.red),
      title: const Text(
        "John Doe",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {},
    );
  }
}
