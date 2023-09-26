import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/pages/login/new_user_register.dart';
import 'package:brunohsp_app/widgets/pagesLayouts/default_menu_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  wrapButtons() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: Calculate.widthWithColumns(
                3, MediaQuery.of(context).size.width),
            child: FilledButton.tonal(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DefaultMenuPage(),
                    ),
                  );
                }
              },
              child: const Text('Entrar'),
            ),
          ),
        ),
        SizedBox(
          width:
              Calculate.widthWithColumns(3, MediaQuery.of(context).size.width),
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewUserRegister(),
                ),
              );
            },
            child: const Text('Cadastrar'),
          ),
        ),
      ],
    );
  }

  wrapInputs() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (input) {
              if (TextFormFieldValidations.isEmpty(input)) return "Campo está vazio!";

              return TextFormFieldValidations.isValidEmail(input!)
                  ? null
                  : "Login deve ser um email!";
            },
            controller: loginController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Login',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (input) {
              return TextFormFieldValidations.isEmpty(input)
                  ? "Campo está vazio!"
                  : null;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 96),
                child: SizedBox(
                  width: Calculate.widthWithColumns(
                      2, MediaQuery.of(context).size.width),
                  height: Calculate.widthWithColumns(
                      2, MediaQuery.of(context).size.width),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
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
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 15,
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const Text(
            'Login',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
            ),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
