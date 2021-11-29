import 'package:app_ifap/provider/users.dart';
import 'package:app_ifap/routes/app_routes.dart';
import 'package:app_ifap/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ninjas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        color: Colors.black26,
        child: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, index) => UserTile(
            user: users.byIndex(index),
          ),
        ),
      ),
    );
  }
}
