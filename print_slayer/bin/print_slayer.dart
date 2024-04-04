import 'package:args/args.dart';
import 'package:print_slayer/cleancode.dart';

void main(List<String> args) {
  final parser = ArgParser();
  parser.addFlag('help',
      abbr: 'h', negatable: false, help: 'Prints Usage Information.');
  parser.addMultiOption('ignore',
      abbr: 'i', help: 'List of filenames to ignore during cleanup.');
  parser.addFlag('debug',
      abbr: 'd',
      negatable: false,
      help: 'Remove debugPrint statements as well.');

  final argResults = parser.parse(args);

  if (argResults['help'] == true) {
    print(parser.usage);
    return;
  }

  final bool debugPrint = argResults['debug'] ?? false;
  final List<String> ignoreList = argResults['ignore'] ?? [];
  cleanCode(ignoreList, debugPrint: debugPrint);
}
