import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/services/notes_service.dart';
import 'dart:html';

class NotesModify extends StatefulWidget {

  final String noteID;
  NotesModify({this.noteID});

  @override
  _NotesModifyState createState() => _NotesModifyState();
}

class _NotesModifyState extends State<NotesModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {

    /*** Setting loading progress bar ***/
    setState(() {
      _isLoading = true;
    });

    notesService.getNote(widget.noteID)
    .then((response){
      /*** Setting loading off ***/
      setState(() {
        _isLoading = false;
      });
      if(response.error){
        errorMessage = response.errormessage ?? 'An error occured';
      }
      note = response.data;

      window.console.debug("This is the note value : \n");
      window.console.debug(note);

      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editing Note" : "Create Note" ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Note title"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: "Note content"
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit',
                style: TextStyle(
                  color: Colors.white
                ),),
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
