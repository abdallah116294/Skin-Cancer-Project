import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  //final void Function()? onTap;
  final String title;
  final Widget? leading;
  final VoidCallback? onTap;

  const ProfileWidget(
      {super.key, this.onTap, this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.shade100,
      color: Colors.white,
      child: ListTile(
        splashColor: const Color(0xFF6671EB).withOpacity(.5),
        onTap:onTap,
        leading: leading,
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF6671EB)),
      ),
    );
  }
}