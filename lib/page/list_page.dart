import 'package:flutter/material.dart';
import 'package:lista_sql/db/operation.dart';
import 'package:lista_sql/models/note.dart';
import 'package:lista_sql/page/save_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SavePage.route);
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text("Listado"),
      ),
      body: _MyList(),
    );
  }
}

class _MyList extends StatefulWidget {
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return _creeateItem(notes[index]);
        });
  }

  _loadData() async {
    List<Note> auxNote = await Operation().getNotes();
    setState(() {
      notes = auxNote;
    });
  }

  _creeateItem(Note note) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.content),
    );
  }
}
