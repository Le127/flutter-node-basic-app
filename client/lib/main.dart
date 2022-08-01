import 'package:flutter/material.dart';
import 'package:users_app_client/api/server_api.dart';

import 'models/users.dart';

void main() {
  ServerApi.baseUrlplatform();
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> usersData = [];

  @override
  void initState() {
    ServerApi.getUsers('/users').then((usersDB) {
      setState(() {
        usersData = usersDB.users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserList'),
        backgroundColor: Colors.indigo[800],
      ),
      body: ListView.builder(
        itemCount: usersData.isEmpty ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$index',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(usersData[index].avatar),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(usersData[index].firstName),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ServerApi.deleteUsers('/users/delete');
        setState(() {
          usersData = [];
        });
      }),
    );
  }
}
