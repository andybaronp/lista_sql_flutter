import 'package:flutter/material.dart';
import 'package:lista_sql/db/operation.dart';
import 'package:lista_sql/models/note.dart';

class SavePage extends StatelessWidget {
  static const String route = '/save';
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    // argumento recibbbido
    Note note = ModalRoute.of(context)!.settings.arguments as Note;

    _init(note);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guardar"),
      ),
      body: _buildFrom(note),
    );
  }

  _init(Note note) {
    titleController.text = note.title;
    contentController.text = note.content;
  }

  Widget _buildFrom(Note note) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Título", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: contentController,
              maxLines: 8,
              maxLength: 1000,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un contenido';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Contenido", border: OutlineInputBorder()),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    minimumSize:
                        WidgetStatePropertyAll(Size(double.infinity, 50))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (note.id != null) {
                      note.title = titleController.text;
                      note.content = contentController.text;
                      Operation().updateNote(note);
                    } else {
                      Operation().insertNote(Note(
                          title: titleController.text,
                          content: contentController.text));
                    }
                  }
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
