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
            Navigator.pushNamed(context, SavePage.route,
                arguments: Note.empty());
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
    return Dismissible(
      key: Key(note.id.toString()),
      background: Container(
        color: const Color.fromARGB(198, 247, 19, 3),
        child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      behavior: HitTestBehavior.opaque,
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        await Operation().deleteNote(note.id);
        _loadData();
      },
      child: ListTile(
        trailing: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, SavePage.route, arguments: note);
            },
            child: const Icon(Icons.edit)),
        title: Text(note.title),
        subtitle: Text(note.content),
      ),
    );
  }
}
