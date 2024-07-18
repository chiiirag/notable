import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  // Controllers for managing title and body input fields.
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  // Reference to Firebase Realtime Database for storing notes.
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('notes');

  // Handles the logic when adding or updating a note.
  Future<void> onAddUpdateNoteClick(
      NoteModel? noteModel, BuildContext context) async {
    if (noteModel != null) {
      updateData(noteModel, context);
    } else {
      createNote(context);
    }
  }

  // Creates a new note in Firebase Realtime Database.
  Future<void> createNote(BuildContext context) async {
    try {
      // Generate a unique key for the new note.
      final String? key = databaseReference.push().key;

      emit(AddNoteLoading());
      if (key != null) {
        // Retrieve the current user's document ID from SharedPreferences
        String? documentId = await getDocumentId(context);

        // Prepare the data to be stored in the database.
        final requestData = {
          "title": titleController.text,
          "description": bodyController.text,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "id": key,
          "userId": documentId,
        };
        // Store the data in Firebase Realtime Database.
        await databaseReference.child(key).set(requestData);

        // Clear the input fields after successful note creation.
        titleController.clear();
        bodyController.clear();

        // Emit state to navigate to the note screen after successful note creation.
        emit(AddNoteNavigateToNote());
      }
    } on FirebaseException catch (e) {
      log('Failed with error code: ${e.code}');
      log(e.message ?? "");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
  }

  // Updates a new note in Firebase Realtime Database.
  void updateData(NoteModel? noteModel, BuildContext context) {
    try {
      final String? key = noteModel?.id;
      emit(AddNoteLoading());

      // Prepare the data to be stored in the database.
      final requestData = {
        "title": titleController.text,
        "description": bodyController.text,
      };
      if (key != null) {
        // Updates the data in Firebase Realtime Database.
        databaseReference.child(key).update(requestData);

        // Clear the input fields after successful note creation.
        titleController.clear();
        bodyController.clear();

        // Emit state to navigate to the note screen after successful note creation.
        emit(AddNoteNavigateToNote());
      } else {
        log('key Not Found');
      }
    } on FirebaseException catch (e) {
      log('Failed with error code: ${e.code}');
      log(e.message ?? "");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
  }

  // Function: getDocumentId
  // Description: Retrieves a document ID from SharedPreferences asynchronously.
  // Returns: A Future that resolves to a String containing the document ID, or null if not found.
  // Throws: Any error that occurs during SharedPreferences access.
  static Future<String?> getDocumentId(BuildContext context) async {
    try {
      // Accessing SharedPreferences instance asynchronously.
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieving the document ID from SharedPreferences.
      return prefs.getString('documentId');
    } catch (e) {
      // Error handling: Catching any errors that occur during SharedPreferences access.
      // Here you can log the error, notify the user, or handle it as needed.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString() ?? "")));
      throw Exception(
          'Failed to retrieve document ID'); // Re-throwing the error for higher level handling
    }
  }
}
