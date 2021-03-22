import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_create/mixins/provided_state.dart';
import 'package:groovin_create/services/user_prefs_service.dart';
import 'package:groovin_create/widgets/elevated_icon_button.dart';
import 'package:groovin_create/widgets/text_editing_controller_builder.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with Provided {
  final _formKey = GlobalKey<FormState>();
  bool? useDefaultDescription;
  String? savePath;

  @override
  void initState() {
    super.initState();
    savePath = prefsService.prefsStream.valueWrapper!.value.defaultSavePath;
    useDefaultDescription =
        prefsService.prefsStream.valueWrapper!.value.shouldUseDefaultDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<UserPrefs>(
        stream: prefsService.prefsStream,
        initialData: prefsService.prefsStream.valueWrapper!.value,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 28,
                child: MoveWindow(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextEditingControllerBuilder(
                          text: savePath,
                          builder: (context, controller) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller,
                                    onSaved: (value) {
                                      final dir = Directory(value!);
                                      if (dir.existsSync()) {
                                        prefsService
                                            .setDefaultSavePath(dir.path);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Default save path',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                ElevatedIconButton(
                                  icon: Icon(Icons.folder_open),
                                  onPressed: () async {
                                    try {
                                      final path = await FileSelectorPlatform
                                          .instance
                                          .getDirectoryPath();
                                      setState(() => savePath = path);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextEditingControllerBuilder(
                          text: snapshot.data?.defaultPackage,
                          builder: (context, controller) {
                            return TextFormField(
                              controller: controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Package cannot be empty';
                                }

                                //todo: more validation

                                return null;
                              },
                              onSaved: (value) =>
                                  prefsService.setDefaultPackage(value!),
                              decoration: InputDecoration(
                                labelText: 'Default package',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Checkbox(
                              value: useDefaultDescription,
                              onChanged: (value) {
                                setState(() => useDefaultDescription = value);
                              },
                            ),
                            const SizedBox(width: 8.0),
                            Text('Use default project description')
                          ],
                        ),
                        if (useDefaultDescription!) ...[
                          const SizedBox(height: 8.0),
                          TextEditingControllerBuilder(
                            text: snapshot.data?.defaultDescription,
                            builder: (context, controller) {
                              return TextFormField(
                                controller: controller,
                                onSaved: (value) =>
                                    prefsService.setDefaultDescription(value!),
                                decoration: InputDecoration(
                                  labelText: 'Default project description',
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown.shade800,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('CLOSE'),
                    ),
                  ),
                  ButtonBar(
                    buttonPadding: EdgeInsets.all(16),
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.lerp(
                              Colors.blue.shade800, Colors.grey.shade800, .5),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            prefsService.setShouldUseDefaultDescription(
                                useDefaultDescription!);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('SAVE'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
