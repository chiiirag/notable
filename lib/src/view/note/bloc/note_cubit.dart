import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../model/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  // List to store the data retrieved from the database
  List<Map<dynamic, dynamic>> dataList = [];

  // Notifier for holding the list of NoteModel objects
  final ValueNotifier<List<NoteModel>> dataNotifier = ValueNotifier([]);

  // Notifier to indicate whether data is currently being loaded
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(true);

  // Notifier for storing any error messages encountered
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  // Reference to the "notes" node in the Firebase Realtime Database
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('notes');

  /// Fetches the notes from the Firebase Realtime Database.
  ///
  /// Listens for changes to the "notes" node in the Firebase Realtime Database.
  /// Updates the [dataNotifier] with the fetched notes and sets [loadingNotifier] to false once loading is complete.
  /// In case of an error, it updates [errorNotifier] with an error message.
  Future<void> getNotes(BuildContext context) async {
    try {
      databaseReference.onValue.listen(
        (event) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          if (data != null) {
            final dataList = <NoteModel>[];
            data.forEach((key, value) {
              final item = NoteModel.fromJson(value as Map<dynamic, dynamic>);
              dataList.add(item);
            });
            dataNotifier.value = dataList;
          } else {
            dataNotifier.value = [];
          }

          loadingNotifier.value = false;
        },
        onError: (error) {
          loadingNotifier.value = false;
          errorNotifier.value = 'Error fetching data: $error';
          log('Error fetching data: $error', error: error);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString() ?? "")));
        },
      );
    } catch (e) {
      // Catch any exceptions and set the errorNotifier with the exception message
      loadingNotifier.value = false;
      errorNotifier.value = 'An unexpected error occurred: $e';
      log('An unexpected error occurred: $e', error: e);
    }
  }

  /// Deletes a note from the Firebase Realtime Database.
  ///
  /// Given a record key, it removes the corresponding note from the "notes" node.
  /// Logs any exceptions that occur during the delete operation.
  ///
  /// [recordKey] is the unique identifier of the note to be deleted.
  void deleteData(String recordKey, BuildContext context) {
    try {
      // Remove the note with the given record key
      databaseReference.child(recordKey).remove().then((_) {
        log('Successfully deleted note with key: $recordKey');
      }).catchError((error) {
        // Log any errors that occur during the remove operation
        log('Failed to delete note with key $recordKey: $error', error: error);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString() ?? "")));
      });
    } catch (e) {
      // Catch any exceptions and log the error
      log('An unexpected error occurred while deleting note with key $recordKey: $e',
          error: e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString() ?? "")));
    }
  }
}
