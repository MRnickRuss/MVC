import 'package:flutter/material.dart';
import '../views/note_view.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   title: 'Заметки',
   theme: ThemeData(
    primarySwatch: Colors.blue,
   ),
   home: NoteView(),
  );
 }
}