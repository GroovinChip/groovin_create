import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groovin_create/models/build_config.dart';
import 'package:groovin_create/provided_state.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:groovin_create/settings.dart';
import 'package:groovin_create/widgets/buttons/create_button.dart';
import 'package:groovin_create/widgets/buttons/next_button.dart';
import 'package:groovin_create/widgets/buttons/previous_button.dart';
import 'package:groovin_create/widgets/elevated_icon_button.dart';
import 'package:groovin_create/widgets/text_editing_controller_builder.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

class Creator extends StatefulWidget {
  @override
  _CreatorState createState() => _CreatorState();
}

class _CreatorState extends State<Creator> with Provided {
  int _pageIndex = 0;
  PageController _pageController;
  final _formKey = GlobalKey<FormState>();

  BuildConfig _config = BuildConfig(
    projectName: 'my_app',
    description: 'A new Flutter application.',
  );

  String result = '';
  bool creatingProject = false;
  bool success;

  @override
  void initState() {
    super.initState();
    _config.projectLocation = prefsService.prefsStream.value.defaultSavePath;
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            child: StreamBuilder<UserPrefs>(
              stream: prefsService.prefsStream,
              initialData: prefsService.prefsStream.value,
              builder: (context, snapshot) {
                final userPrefs = snapshot?.data;
                if (success == null || !success) {
                  return Form(
                    key: _formKey,
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
                                  return TextFormField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      labelText: 'Project Name',
                                    ),
                                    onChanged: (value) =>
                                        _config.projectName = value,
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
                                        return TextFormField(
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
                                    onPressed: () async {
                                      final path = await FileSelectorPlatform
                                          .instance
                                          .getDirectoryPath();
                                      setState(
                                          () => _config.projectLocation = path);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextEditingControllerBuilder(
                                text: userPrefs.shouldUseDefaultDescription
                                    ? userPrefs.defaultDescription
                                    : '',
                                builder: (context, controller) {
                                  return TextFormField(
                                    controller: controller,
                                    onChanged: (value) =>
                                        _config.description = value,
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
                                text:
                                    '${userPrefs.defaultPackage}.${_config.projectName}',
                                builder: (context, controller) {
                                  return TextFormField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      labelText: 'Package Name',
                                    ),
                                    onChanged: (value) =>
                                        _config.packageName = value,
                                    onSaved: (value) =>
                                    _config.packageName = value,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (creatingProject) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (success != null && success) {
                  return Center(
                    child: Text(
                      'Created a Groovin app! 🍪',
                      style: theme.textTheme.headline6,
                    ),
                  );
                }
                if (success != null && !success) {
                  return Center(
                    child: Text(
                      'App creation failed',
                      style: theme.textTheme.headline6,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          if (success == null || !success) ...[
            Stack(
              //alignment: Alignment.centerLeft,
              children: [
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: ElevatedIconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => Settings(),
                      ),
                    )
                        .whenComplete(() => setState(() {})),
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
                      CreateButton(
                        onPressed: () async {
                          // validate
                          //...
                          _formKey.currentState.save();
                          // run command
                          setState(() => creatingProject = true);
                          var _result = await Process.run(
                            'groovin',
                            [
                              'create',
                              //'${_config.projectLocation}',
                              '${_config.projectName}',
                              '--description=${_config.description}',
                              '--package_id=${_config.packageName}',
                            ],
                            workingDirectory: '${_config.projectLocation}/',
                          );

                          print(_result.stdout);
                          if (_result.exitCode == 0) {
                            setState(() => creatingProject = false);
                            setState(() => success = true);
                            if (kReleaseMode && Platform.isMacOS) {
                              await Future.delayed(Duration(seconds: 2));
                              exit(0);
                            }
                          } else {
                            setState(() => creatingProject = false);
                            setState(() => success = false);
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],

        ],
      ),
    );
  }
}
