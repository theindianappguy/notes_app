import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/services/notes_service.dart';
import 'package:notes_app/views/notes_list.dart';

void setupLocator(){
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutte Notes App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesList(),
    );
  }
}
