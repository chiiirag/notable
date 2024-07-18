import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final userNameCtrl = TextEditingController();

  // Function: onLoginClick
// Description: Handles the login button click event, validates user input,
// and creates a collection with user data if the input is valid.
// Parameters:
//   - context: BuildContext for accessing Flutter context information.
// Throws: Any error that occurs during the createCollection operation.
  Future<void> onLoginClick(BuildContext context) async {
    try {
      // Checking if the username field is not empty
      if (userNameCtrl.text.isNotEmpty) {
        // Creating request data with username and current timestamp
        final Map<String, dynamic> requestData = {
          "name": userNameCtrl.text,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
        };

        // Calling createCollection function to store user data
        await createCollection(requestData, context);
      } else {
        // Showing a snackbar if username field is empty
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Please enter name')));
      }
    } catch (e) {
      // Error handling: Catching any errors that occur during the createCollection operation.
      // Here you can log the error, notify the user, or handle it as needed.
      log('Error in onLoginClick function: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to perform login. Please try again later.')),
      );
    }
  }

  // Function: createCollection
// Description: Creates a new document in the "users" collection in Firestore
// using the provided requestData. Stores the generated document ID in
// SharedPreferences upon successful creation.
// Parameters:
//   - requestData: A map containing data to be stored in the Firestore document.
// Throws: Any FirebaseException that occurs during Firestore operations.
  Future<void> createCollection(
      Map<String, dynamic> requestData, BuildContext context) async {
    try {
      // Emitting a loading state to indicate login process is in progress.
      emit(LoginLoading());

      // Adding a new document to the "users" collection in Firestore.
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("users").add(requestData);

      // Retrieving the generated document ID.
      String documentId = docRef.id;

      // Storing the document ID in SharedPreferences.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('documentId', documentId);

      // Emitting state to navigate to the note screen after successful login.
      emit(LoginNavigateToNote());
    } on FirebaseException catch (e) {
      // Error handling: Catching Firebase exceptions that occur during Firestore operations.
      // Logging the error details for debugging purposes.
      log('Failed with error code: ${e.code}');
      log(e.message ?? "");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "")));
      // Optionally, you can re-throw the FirebaseException or handle it in other ways.
      throw e;
    }
  }
}
