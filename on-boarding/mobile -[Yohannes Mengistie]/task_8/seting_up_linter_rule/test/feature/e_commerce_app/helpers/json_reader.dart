import 'dart:io';

String readJson(String path) {
  final file = File(path);
  print('Looking for file at: ${file.absolute.path}');

  if (!file.existsSync()) {
    print("File does not exist: ${file.absolute.path}");
    return '';
  }

  try {
    return file.readAsStringSync();
  } catch (e) {
    print('Error reading JSON file: $e');
    return '';
  }
}
