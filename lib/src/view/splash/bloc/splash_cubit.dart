import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  // Function: initialTime
// Description: Initiates app initialization flow by emitting different states based on the presence of a document ID.
  Future<void> initialTime(BuildContext context) async {
    try {
      // Emitting a loading state to indicate the splash screen is in progress.
      emit(SplashLoadingState());

      // Attempting to retrieve a document ID asynchronously.
      String? documentId = await getDocumentId(context);

      // Checking if a document ID is retrieved.
      if (documentId != null) {
        // If document ID exists, emit state to navigate to note screen.
        emit(SplashNavigateToNote());
      } else {
        // If document ID does not exist, delay for 5 seconds and then emit state to navigate to login screen.
        await Future.delayed(const Duration(seconds: 5));
        emit(SplashNavigateToLogin());
      }
    } catch (e) {
      // Error handling: Catching any errors that occur during the asynchronous operations.
      // Here you can log the error, notify the user, or handle it as needed.
      log('Error in initialTime function: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString() ?? "")));
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
