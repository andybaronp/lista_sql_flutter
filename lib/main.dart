import 'package:flutter/material.dart';
import 'package:lista_sql/page/list_page.dart';
import 'package:lista_sql/page/save_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      initialRoute: ListPage.route,
      routes: {
        ListPage.route: (context) => const ListPage(),
        SavePage.route: (context) => const SavePage(),
      },
      // title: 'Material App',
      // home: const ListPage(),
    );
  }
}
