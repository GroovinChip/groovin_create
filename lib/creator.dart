import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:groovin_create/models/build_config.dart';
import 'package:groovin_create/widgets/finish_button.dart';
import 'package:groovin_create/widgets/next_button.dart';
import 'package:groovin_create/widgets/previous_button.dart';
import 'package:groovin_create/widgets/text_editing_controller_builder.dart';

class Creator extends StatefulWidget {
  @override
  _CreatorState createState() => _CreatorState();
}

class _CreatorState extends State<Creator> {
  int _pageIndex = 0;
  PageController _pageController;
  BuildConfig _config = BuildConfig(
    projectName: 'my_app',
    projectLocation: '/Users/groov/development/flutter_projects/apps',
    description: 'A new Flutter application.',
    packageName: 'com.example.my_app',
  );

  String result = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  void _next() {
    setState(() {
      _pageIndex++;
      _pageController.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _previous() {
    setState(() {
      _pageIndex--;
      _pageController.previousPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28,
            child: MoveWindow(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Groovin Create',
                  style: theme.textTheme.subtitle2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Image(
                    image: AssetImage(
                      'assets/images/cookie.png',
                    ),
                  ),
                ),
                Text(
                  'New Flutter Application',
                  style: theme.textTheme.headline5,
                ),
                FlutterLogo(
                  size: 75,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      TextEditingControllerBuilder(
                        text: _config.projectName,
                        builder: (context, controller) {
                          return TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Project Name',
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      //todo: maybe try a Stack?
                      Row(
                        children: [
                          Expanded(
                            child: TextEditingControllerBuilder(
                              text: _config.projectLocation,
                              builder: (context, controller) {
                                return TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Project Location',
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            tooltip: 'Choose directory',
                            color: theme.iconTheme.color,
                            icon: Icon(Icons.folder_open),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextEditingControllerBuilder(
                        text: _config.description,
                        builder: (context, controller) {
                          return TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      TextEditingControllerBuilder(
                        text: _config.packageName,
                        builder: (context, controller) {
                          return TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Package Name',
                            ),
                            onChanged: (value) => _config.packageName = value,
                          );
                        },
                      ),
                      //Text(result),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            buttonPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              if (_pageIndex > 0) ...[
                PreviousButton(
                  onPressed: _previous,
                ),
              ],
              if (_pageIndex == 0) ...[
                NextButton(
                  onPressed: _next,
                ),
              ],
              if (_pageIndex == 1) ...[
                FinishButton(
                  onPressed: () async {
                    // validate
                    // run command
                    try {
                      final myDir = new Directory('${_config.projectLocation}');
                      myDir.exists().then((value) => print(value));
                      var _result = await Process.run(
                        'groovin',
                        [
                          'create',
                          '${_config.projectName}',
                          '${_config.description}',
                          '${_config.packageName}',
                        ],
                        workingDirectory: '${_config.projectLocation}/',
                      );
                      print(_result.stdout);
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
