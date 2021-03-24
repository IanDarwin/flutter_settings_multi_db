import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'config/settings_cache.dart';
import 'ui/settings_page.dart';

/// Set this true to test the multi-db code, otherwise the standard
/// SharedPreferences-based cache provider will be used.
bool test = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (test) {
    await Settings.init(cacheProvider: SettingsCacheProvider());
  } else {
    await Settings.init();
  }
  runApp(MyApp());
}

SharedPreferences prefs;
FlutterSecureStorage storage = FlutterSecureStorage();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo flutter_settings_screen multi-db',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Demo flutter_settings_screen multi-db'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Shows the Settings plugin with multiple databases',
            ),
            TextButton(
              child: Text("Press me. I dare you."),
               onPressed: () {
                 Navigator.push(context,
                   MaterialPageRoute(
                     builder: (context) => SettingsPage(),
                   ),
                 );
               }
            )
          ],
        ),
      ),
    );
  }
}
