import 'dart:convert';

import 'package:notes_app/models/api_responce.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = "http://api.notes.programmingaddict.com/";
  static const headers = {"apiKey": "08d7a0e3-d57c-cd93-5da0-06a313f12832"};

  Future<APIResponse<List<NotesForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NotesForListing>[];
        for (var item in jsonData) {
          notes.add(NotesForListing.fromJson(item));
        }

        return APIResponse<List<NotesForListing>>(data: notes);
      }
      return APIResponse<List<NotesForListing>>(
          error: true, errormessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NotesForListing>>(
        error: true, errormessage: 'An error occured'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final note = Note.fromJson(jsonData);
        return APIResponse<Note>(data: note);
      }
      return APIResponse<Note>(error: true, errormessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Note>(error: true, errormessage: 'An error occured'));
  }
}
