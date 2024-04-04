import 'dart:io';
import 'package:path/path.dart' as path;

void cleanCode(List<String> ignoreList, {bool debugPrint = false}) {
  final currentDirectory = Directory.current;
  final files = listFiles(currentDirectory);
  // regex to remove print statements
  final printStatementsRegex = RegExp(r'print\s*\(.+\);');
  // regex to remove debugPrint statements
  final debugPrintStatementsRegex = RegExp(r'debugPrint\s*\(.+\);');

  for (final file in files) {
    if (ignoreList.contains(path.basename(file.path))) {
      print("Ignoring ${path.basename(file.path)}");
      continue;
    }

    final content = file.readAsStringSync();
    var modifiedContent = content.replaceAll(printStatementsRegex, '');
    if (debugPrint) {
      modifiedContent =
          modifiedContent.replaceAll(debugPrintStatementsRegex, '');
    }

    if (content != modifiedContent) {
      file.writeAsStringSync(modifiedContent);
      print(
          'print/debugPrint Statements Removed in ${path.relative(file.path)}');
    }
  }

  print('Code Cleanup Completed!');

  // format the dart files in the lib directory using dart format
  Process.runSync('dart', ['format', 'lib'], runInShell: true);
  print('Formatted Dart Files in lib directory');
}

List<File> listFiles(Directory directory) {
  final files = <File>[];

  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      files.add(entity);
    }
  }

  return files;
}
