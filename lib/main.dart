import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';

void main() => runApp(const NoteApp());

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {"/": (context) => const HomeScreen()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Taking App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (snapshot.data == Null) {
                  return const Center(
                    child: Text("You don't have any data. First create one"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        String title = snapshot.data[index]['title'];
                        String body = snapshot.data[index]['body'];
                        String createdTime =
                            snapshot.data[index]['createdTime'];
                        // int id = snapshot.data[index]['id'];
                        return Card(
                          child: ListTile(
                            title: Text(title),
                            subtitle: Text(body),
                            trailing: Text(createdTime),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          }
          return Container();
        },
      ),
    );
  }
}
