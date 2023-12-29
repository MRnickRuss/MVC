import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/note_model.dart';

class NoteEditController extends ControllerMVC {
  factory NoteEditController() {
    _this ??= NoteEditController._();
    return _this!;
  }
  static NoteEditController? _this;

  NoteEditController._();

  Note? note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void loadNote(Note? note) {
    if (note != null) {
      titleController.text = note.title;
      descriptionController.text = note.description;
    }
  }

  void saveNote() {
    note = Note(
      title: titleController.text,
      description: descriptionController.text,
    );
  }
}
