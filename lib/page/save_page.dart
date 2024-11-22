import 'package:flutter/material.dart';
import 'package:lista_sql/db/operation.dart';
import 'package:lista_sql/models/note.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});
  static const String route = '/save';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guardar"),
      ),
      body: Container(
        child: _FormSave(),
      ),
    );
  }
}

class _FormSave extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    Operation().insertNote(Note(
                        title: titleController.text,
                        content: contentController.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Guardado con éxito')),
                    );
                  }
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
