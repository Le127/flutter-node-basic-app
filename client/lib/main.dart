import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:users_app_client/api/server_api.dart';

import 'models/users.dart';

void main() {
  ServerApi.baseUrlplatform();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> usersData = [];
  bool indicator = true;

  @override
  void initState() {
    ServerApi.getUsers('/users').then((usersDB) {
      setState(() {
        usersData = usersDB.users;
        indicator = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: "Delete all users",
              onPressed: () {
                ServerApi.deleteUsers('/users/delete');
                setState(() {
                  usersData = [];
                });
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text('UserList'),
        backgroundColor: Colors.indigo[800],
      ),
      //Scrollable in Desktop with mouse
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: indicator
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: usersData.isEmpty ? 0 : usersData.length,
                itemBuilder: (BuildContext context, int index) {
                  //User
                  final user = usersData[index];

                  return Dismissible(
                    key: Key(user.id),
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(width: 20),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      ServerApi.deleteUser("/users/delete", user.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${user.firstName} dismissed')));
                    },
                    child: Card(
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
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user.firstName),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() => indicator = true);
          await ServerApi.createUser('/users/create');
          ServerApi.getUsers('/users').then((usersDB) {
            setState(() {
              usersData = usersDB.users;
              indicator = false;
            });
          });
        },
        tooltip: "Create five Users",
        child: const Icon(Icons.people),
      ),
    );
  }
}
