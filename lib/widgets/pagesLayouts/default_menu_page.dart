// ignore_for_file: deprecated_member_use

import 'package:brunohsp_app/pages/menus/gameplay_menu.dart';
import 'package:brunohsp_app/pages/menus/main_menu.dart';
import 'package:brunohsp_app/pages/menus/sheets_menu.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DefaultMenuPage extends StatefulWidget {
  const DefaultMenuPage({Key? key}) : super(key: key);

  @override
  State<DefaultMenuPage> createState() => _DefaultMenuPageState();
}

class _DefaultMenuPageState extends State<DefaultMenuPage> {
  int currentTab = 0;
  final List<Widget> screens = [
    const MainMenu(),
    const GameplayMenu(),
    const SheetsMenu(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MainMenu();
  String title = 'Menu Inicial';

  buildFAB() {
    return SizedBox(
      height: 72.0,
      width: 72.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              title = 'Gameplay';
              currentScreen = const GameplayMenu();
              currentTab = 2;
            });
          },
          backgroundColor: Colors.amber.shade300,
          elevation: 4,
          shape: const StarBorder.polygon(sides: 6),
          child: SvgPicture.asset(
            'assets/icons/bottomBarIcons/dice.svg',
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  buildBottomAppBar() {
    return BottomAppBar(
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)))),
      color: Theme.of(context).colorScheme.primary,
      child: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  title = 'Menu Inicial';
                  currentScreen = const MainMenu();
                  currentTab = 1;
                });
              },
              icon: const Icon(
                Icons.home,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  title = 'Personagens';
                  currentScreen = const SheetsMenu();
                  currentTab = 3;
                });
              },
              icon: SvgPicture.asset(
                'assets/icons/bottomBarIcons/chart.svg',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 1:
        context.read<AuthService>().logout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFAB(),
      bottomNavigationBar: buildBottomAppBar(),
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: ((context) => [
                  const PopupMenuItem<int>(value: 1, child: Text('Sair')),
                ]),
          ),
        ],
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
