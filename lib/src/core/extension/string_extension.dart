extension StringExtension on String {
  //Capitalize first letter of string
  String capitalizeFirstLetter() {
    if (isEmpty) return this; // Handle edge case of empty string
    return this[0].toUpperCase() + substring(1);
  }
}
