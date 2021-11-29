// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:app_ifap/models/user.dart';
import 'package:app_ifap/provider/users.dart';
import 'package:app_ifap/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = user.urlAvatar == null || user.urlAvatar!.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.urlAvatar!),
          );
    return Card(
      elevation: 2,
      color: Colors.orangeAccent[100],
      child: ListTile(
        leading: avatar,
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () => _modalConfirmedDelete(context),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _modalConfirmedDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir o Ninja'),
        content: Text('Tem certeza???'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('NÃO'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<Users>(
                context,
                listen: false,
              ).remove(user);
              Navigator.of(context).pop();
            },
            child: Text('SIM'),
          )
        ],
      ),
    );
  }
}
