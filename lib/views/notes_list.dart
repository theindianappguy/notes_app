import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/models/api_responce.dart';
import 'package:notes_app/models/notes_for_listing.dart';
import 'package:notes_app/services/notes_service.dart';
import 'package:notes_app/views/note_delete_file.dart';
import 'package:notes_app/views/note_modify.dart';

class NotesList extends StatefulWidget {

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NotesService get service => GetIt.I<NotesService>();

  //List<NotesForListing> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  APIResponse<List<NotesForListing>> apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    //notes = service.getNotesList();
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async{

    setState(() {
      _isLoading = true;
    });

    apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NotesModify()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Builder(
        builder: (_){
          if(_isLoading){
            return Center(child: CircularProgressIndicator());
          }

          if(apiResponse.error){
            return Center(child: Text(apiResponse.errormessage));
          }

          return ListView.separated(
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(apiResponse.data[index].noteID),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      apiResponse.data[index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        "Last edited on ${apiResponse.data[index].latestEditDateTime ??
                            formatDateTime(apiResponse.data[index].createDataTime)
                      }"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NotesModify(
                            noteID: apiResponse.data[index].noteID,
                          )));
                    },
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.green,
              ),
              itemCount: apiResponse.data.length);
        },
      )
    );
  }
}
