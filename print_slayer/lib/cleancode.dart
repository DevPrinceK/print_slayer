import 'dart:io';
import 'package:path/path.dart' as path;

void cleanCode(List<String> ignoreList) {
  final currentDirectory = Directory.current;
  final files = listFiles(currentDirectory);
  final printStatementsRegex = RegExp(r'print\s*\(.+\);');

  for (final file in files) {
    if (ignoreList.contains(path.basename(file.path))) {
      print("Ignoring ${path.basename(file.path)}");
      continue;
    }

    final content = file.readAsStringSync();
    final modifiedContent = content.replaceAll(printStatementsRegex, '');

    if (content != modifiedContent) {
      file.writeAsStringSync(modifiedContent);
      print('Print Statements Removed in ${path.relative(file.path)}');
    }
  }

  print('Code Cleanup Completed!');
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
