// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:brunohsp_app/pages/login/login.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:brunohsp_app/widgets/pagesLayouts/default_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.user == null)
      return const Login();
    else
      return const DefaultMenuPage();
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
