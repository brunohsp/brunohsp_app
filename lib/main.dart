import 'package:brunohsp_app/database/hive_config.dart';
import 'package:brunohsp_app/repositories/characters_repository.dart';
import 'package:brunohsp_app/repositories/dices_repository.dart';
import 'package:brunohsp_app/repositories/notes_repository.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:brunohsp_app/widgets/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveConfig.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => NotesRepository(
            auth: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CharacterRepository(
            auth: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DicesRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'DND',
        theme: ThemeData(
          brightness: Brightness.light,
          colorSchemeSeed: const Color.fromARGB(255, 140, 20, 20),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        home: const AuthCheck(),
      ),
    );
  }
}//app de d&d



