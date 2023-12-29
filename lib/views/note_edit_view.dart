import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/note_model.dart';
import '../controllers/note_edit_controller.dart';

class NoteEditView extends StatefulWidget {
  final Note? note;
  NoteEditView({this.note});

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

class _NoteEditViewState extends StateMVC<NoteEditView> {
  late NoteEditController _con;

  _NoteEditViewState() : super(NoteEditController()) {
    _con = controller as NoteEditController;
  }

  @override
  void initState() {
    super.initState();
    _con.loadNote(widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать заметку'),
        actions: [
          IconButton(
            onPressed: () =>
                {_con.saveNote(), Navigator.pop(context, _con.note)},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _con.titleController,
                decoration: InputDecoration(
                  labelText: 'Заголовок',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _con.descriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Текст',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }
}
