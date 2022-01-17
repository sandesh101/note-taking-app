import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/models/note_models.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title = "";
  String body = "";
  DateTime createdTime = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNotes(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Your Notes"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            createdTime = DateTime.now();
          });
          NoteModel note = NoteModel(
              id: 1, title: title, body: body, createdTime: createdTime);
          addNotes(note);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        label: const Text("Save Note"),
        icon: const Icon(Icons.save_outlined),
        backgroundColor: Colors.black,
      ),
    );
  }
}
