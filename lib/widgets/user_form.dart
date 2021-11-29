import 'package:app_ifap/models/user.dart';
import 'package:app_ifap/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  UserForm({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id!;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['urlAvatar'] = user.urlAvatar!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User?;
    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Ninja'),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name']!,
                    email: _formData['email']!,
                    urlAvatar: _formData['urlAvatar'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Nome do ninja',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O ninja precisa de um nome';
                      }
                    },
                    onSaved: (newValue) => _formData['name'] = newValue!,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email do ninja',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O ninja precisa de um email';
                      }
                    },
                    onSaved: (newValue) => _formData['email'] = newValue!,
                  ),
                  TextFormField(
                    initialValue: _formData['urlAvatar'],
                    decoration: const InputDecoration(
                      labelText: 'URL Avatar',
                      hintText: 'Foto do avatar',
                    ),
                    onSaved: (newValue) => _formData['urlAvatar'] = newValue!,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
