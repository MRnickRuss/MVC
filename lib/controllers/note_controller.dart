import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteController extends ControllerMVC {
  factory NoteController() {
    _this ??= NoteController._();
    return _this!;
  }
  static NoteController? _this;

  NoteController._();

  List<Note> notes = [];
  TextEditingController noteTitleController = TextEditingController();

  Future loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = (prefs.getStringList('notes') ?? []).map((note) {
        List<String> noteData = note.split(',');
        return Note(
          title: noteData[0],
          description: noteData[1],
        );
      }).toList();
    });
  }

  Future saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedNotes = notes.map((note) {
      return '${note.title},${note.description}';
    }).toList();
    await prefs.setStringList('notes', savedNotes);
  }

  void addNote(Note result) async {
    setState(() {
      notes.add(result);
      saveNotes();
    });
  }

  void editNote(int index, Note result) async {
    setState(() {
      notes[index] = result;
      saveNotes();
    });
  }

  void deleteNote(int index) async {
    setState(() {
      notes.removeAt(index);
      saveNotes();
    });
  }
}
