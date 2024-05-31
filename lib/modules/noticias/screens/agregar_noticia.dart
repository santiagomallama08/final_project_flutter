import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/services/firestore.dart';

class AddNoticia extends StatefulWidget {
  const AddNoticia({Key? key}) : super(key: key);

  @override
  State<AddNoticia> createState() => _AddNoticiaState();
}

class _AddNoticiaState extends State<AddNoticia> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _imagenController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  Future<void> _addNoticia() async {
    if (_formKey.currentState!.validate()) {
      final noticia = {
        'titulo': _tituloController.text,
        'imagen': _imagenController.text,
        'descripcion': _descripcionController.text,
      };
      try {
        await addDocumentToCollection('Noticias', noticia);
        Navigator.pop(context, noticia); // Regresar la nueva noticia
      } catch (e) {
        // Maneja el error si la adición del documento falla
        print('Error adding noticia: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar la noticia.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Noticia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(labelText: 'Imagen URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una URL de imagen';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNoticia,
                child: const Text('Agregar Noticia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
