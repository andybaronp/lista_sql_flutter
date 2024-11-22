import 'package:flutter/material.dart';
import 'package:lista_sql/db/operation.dart';
import 'package:lista_sql/page/save_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    Operation().getNotes();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SavePage.route);
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text("Listado"),
      ),
      body: Container(
          child: ListView(
        children: const <Widget>[
          ListTile(
            title: Text("Item 1"),
          ),
          ListTile(
            title: Text("Item 2"),
          ),
          ListTile(
            title: Text("Item 3"),
          ),
          ListTile(
            title: Text("Item 4"),
          ),
        ],
      )),
    );
  }
}
