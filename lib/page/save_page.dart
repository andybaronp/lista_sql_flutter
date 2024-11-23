import 'package:flutter/material.dart';
import 'package:lista_sql/db/operation.dart';
import 'package:lista_sql/models/note.dart';

class SavePage extends StatefulWidget {
  static const String route = '/save';

  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // argumento recibbbido
    Note note = ModalRoute.of(context)!.settings.arguments as Note;

    _init(note);
    return PopScope(
      canPop: note.id == null ? true : false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          //sino tenemos datos que guardar
          if (_formKey.currentState!.validate()) {
            final shouldPop = await _showBackDialog() ?? false;
            if (!shouldPop) {
              return; // No realiza navegación si el usuario cancela.
            }
            if (context.mounted) {
              Navigator.pop(context); // Realiza el pop si el usuario acepta.
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Guardar"),
        ),
        body: _buildFrom(note),
      ),
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

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Salir"),
        content: const Text("¿Desea salir, tiene notas sin guardar?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Sí"),
          ),
        ],
      ),
    );
  }
}
