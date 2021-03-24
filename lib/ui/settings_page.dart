import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../constants.dart';
import '../main.dart' show storage;

int defaultCourseLength = 3;
bool defaultSaveToCal = true;

Future<String> getInstrCode() async {
  return await storage.read(key: Constants.KEY_CODE);
}

/// Activity for Settings.
///
class SettingsPage extends StatefulWidget {

  @override
  SettingsState createState() => new SettingsState();

}

enum OpsUnit {
  Canada,
  USA,
  Taiwan,
  India,
  UK
}

class SettingsState extends State<SettingsPage> {

  OpsUnit defaultOpsUnit;
  final Map<int,String> opsUnitMap = Map();

  SettingsState();

  @override
  void initState() {
    OpsUnit.values.forEach((ou) { opsUnitMap.putIfAbsent(ou.index, ou.toString);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SettingsScreen(title: "Demo Settings Page",
        children: <Widget>[
          SettingsGroup(title: "Instructor Info",
              children: [
                TextInputSettingsTile(
                  title: "Instructor name",
                  settingKey: Constants.KEY_NAME,
                  validator: (instrName) {
                    if (instrName != null && instrName.isNotEmpty)
                      return null;
                    return "Instructor name is required";
                  },
                  errorColor: Colors.redAccent,
                ),
                TextInputSettingsTile(
                  title: "Phone Number",
                  settingKey: Constants.KEY_PHONE,
                  validator: (instrname) {
                    if (instrname != null && instrname.isNotEmpty)
                      return null;
                    // Check for + () - 0-9 - regex
                    return "Callable phone name is required";
                  },
                  errorColor: Colors.redAccent,
                ),
                TextInputSettingsTile(
                  title: "Instructor code",
                  settingKey: Constants.KEY_CODE,
                  validator: (instrCode) {
                    if (instrCode != null && instrCode.isNotEmpty)
                      return null;
                    return "Instructor code is required";
                  },
                  errorColor: Colors.redAccent,
                ),
              ]),
          SettingsGroup(
            title: "Course Info",
            children: [
              DropDownSettingsTile<int>(
                title: 'Default Course Length',
                settingKey: Constants.KEY_COURSE_LENGTH,
                  selected: defaultCourseLength,
                  values: {
                  1: "1",
                  2: "2",
                  3: "3",
                  4: "4",
                  5: "5",
                }
              ),
              DropDownSettingsTile<int>(
                title: 'Default Ops Unit',
                settingKey: Constants.KEY_OPS_UNIT,
                selected: 0,
                values: opsUnitMap,
              ),
              SwitchSettingsTile(
                leading: Icon(Icons.calendar_today_rounded),
                settingKey: Constants.KEY_SAVE_TO_CAL,
                title: 'Add new courses to calendar',
                onChange: (value) {
                  debugPrint('$Constants.KEY_SAVE_TO_CAL: $value');
                },
              ),
            ],
          ),
        ]);
  }
}


