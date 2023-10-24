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
      ],
      child: MaterialApp(
        title: 'DND',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
        ),
        home: const AuthCheck(),
      ),
    );
  }
}//app de d&d



