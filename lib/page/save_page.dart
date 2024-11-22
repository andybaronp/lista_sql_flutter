import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando datos')),
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
