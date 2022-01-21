import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/Utils/characters_colors.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/characters_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      theme: ThemeData(primaryColor: CharactersColors.darkBlue),
      home: const CharactersPage(),
    );
  }
}
