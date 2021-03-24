import 'dart:io';

import 'package:groovin_create/models/build_config.dart';

class ProcessRunner {
  /// Runs the `groovin create` command with the specified arguments.
  ///
  /// Runs the appropriate Process.run configuration based on desktop platform.
  static Future<ProcessResult> groovinCreate(BuildConfig config) async {
    switch (Platform.operatingSystem) {
      case 'macos':
        final command =
            'groovin create ${config.projectName} --description=\'${config.description}\' --package_id=\'${config.packageName}\'';
        return await Process.run(
          '/bin/zsh',
          ['-c', 'source ~/.zshrc && $command'],
          workingDirectory: '${config.projectLocation}',
        );
      case 'windows':
        return await Process.run(
          'groovin',
          [
            'create',
            '${config.projectName}',
            '--description=${config.description}',
            '--package_id=${config.packageName}',
          ],
          runInShell: true,
          workingDirectory: '${config.projectLocation}',
        );
      default:
        throw 'Unsupported platform';
    }
  }
}
