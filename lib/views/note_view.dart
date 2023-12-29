import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../views/note_edit_view.dart';

class NoteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends StateMVC<NoteView> {
  late NoteController _con;

  _NoteViewState() : super(NoteController()) {
    _con = controller as NoteController;
  }

  @override
  void initState() {
    super.initState();
    _con.loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: _con.notes.length,
        itemBuilder: (context, index) {
          String title = _con.notes[index].title;
          String description = _con.notes[index].description;
          return Card(
            child: ListTile(
              title: Text(title),
              subtitle: Text(description),
              onTap: () async {
                Note? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteEditView(note: _con.notes[index]),
                  ),
                );
                if (result != null) {
                  _con.editNote(index, result);
                }
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  bool confirm = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Удалить заметку?'),
                        content: Text(
                            'Вы действительно хотите удалить эту заметку?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Удалить'),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirm) {
                    _con.deleteNote(index);
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Note? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditView()),
          );
          if (result != null) {
            _con.addNote(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
