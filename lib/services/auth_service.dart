// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      this.user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  create(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weaK-password')
        throw AuthException('Senha muito fraca!');
      else if (err.code == 'email-already-in-use')
        throw AuthException('Email já cadastrado');
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (err) {
      print('###############################3 ${err.code}');
      if (err.code == 'user-not-found')
        throw AuthException('Login ou Senha inválidos!');
      else if (err.code == 'wrong-password')
        throw AuthException('Login ou Senha inválidos!');
      else if (err.code == 'INVALID_LOGIN_CREDENTIALS')
        throw AuthException('Login ou Senha inválidos!');
    }
    catch(e){
      throw AuthException('deu ruim');
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
