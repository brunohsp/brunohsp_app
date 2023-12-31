// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewUserRegister extends StatefulWidget {
  const NewUserRegister({Key? key}) : super(key: key);

  @override
  State<NewUserRegister> createState() => _NewUserRegisterState();
}

class _NewUserRegisterState extends State<NewUserRegister> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  createAccount() async {
    try {
      await context
          .read<AuthService>()
          .create(emailController.text, passwordController.text);
    } on AuthException catch (err) {
      onError(err.message);
    }
  }

  onError(String err) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(err),
      ),
    );
  }

  goBack() {
    Navigator.pop(context);
  }

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await createAccount();
              goBack();
            }
          },
          child: const Text('Cadastrar'),
        ),
      ),
    );
  }

  wrapInputs() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input))
                return "Campo está vazio!";
              return TextFormFieldValidations.isValidEmail(input!)
                  ? null
                  : "Email inválido!";
            },
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input))
                return "Campo está vazio!";
              return TextFormFieldValidations.passwordHasTheMinimalCharacters(
                      input!)
                  ? null
                  : "Senha deve conter ao menos 8 caracteres!";
            },
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Senha',
            ),
          ),
        ),
      ],
    );
  }

  wrapBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wrapInputs(),
              wrapButtons(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 15,
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text(
              'Cadastro',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
              ),
            ),
          ),
          body: wrapBody(),
        ),
      ),
    );
  }
}
