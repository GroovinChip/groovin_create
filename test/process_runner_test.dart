import 'package:flutter_test/flutter_test.dart';
import 'package:groovin_create/models/build_config.dart';
import 'package:groovin_create/process_runner.dart';

void main() {
  test('Test ProcessRunner', () async {
    final config = BuildConfig(
      projectName: 'my_app',
      description: 'My App',
      projectLocation: '/Users/groov/development/flutter_projects/experiments',
      packageName: 'dev.groovinchip.my_app',
    );
    expect((await ProcessRunner.groovinCreate(config)).exitCode, 0);
  });
}
