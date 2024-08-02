import 'package:flutter/material.dart';

class SectionListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;

  const SectionListTile({
    required this.title,
    required this.icon,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 20, thickness: 1),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ...items.map((item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(icon),
              title: Text(item),
            )),
      ],
    );
  }
}
