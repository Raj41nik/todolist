import 'package:flutter/material.dart';
import 'package:todolist/auth/authform.dart';
class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
    return AuthForm();
  }
}
