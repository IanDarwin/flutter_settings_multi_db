///
/// Cache provider for Settings, like default but uses Secure Storage 
/// to protect the instructor code transparently.
///
/// Some of the methods used are async, but we can't change
/// the Cache Provider methods to be async, so work around
/// using asyncMethod().then(...)
///
/// TODO: Remove the hard-coded key; make constr take a list of keys to secure.
///
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';
import '../main.dart' show prefs;

class SettingsCacheProvider extends CacheProvider {

	SettingsCacheProvider() {
		print("SettingsCacheProvider::init");
	}

	final storage = FlutterSecureStorage();

	@override
	String getString(String key) {
		print("getString($key");
		if (key == Constants.KEY_CODE) {
			var tmp;
			storage.read(key: Constants.KEY_CODE).then((value) {tmp = value;});
			print("read $tmp");
			return tmp;
		} else {
			var tmp = prefs.getString(key);
			print("fetched $tmp");
			return tmp;
		}
	}

	@override
	Future<void> setString(String key, String value) {
		print("SettingsCache::setString($key,$value)");
		var tmp;
		if (key == Constants.KEY_CODE)
			storage.write(key: Constants.KEY_CODE, value: value).then((v) { });
		else
			prefs.setString(key, value).then((v) { });
	}

	@override
	T getValue<T>(String key, T defaultValue) {
		if (defaultValue is int) {
			return prefs.getInt(key) as T;
		}
		if (defaultValue is double) {
			return prefs.getDouble(key) as T;
		}
		if (defaultValue is bool) {
			return prefs.getBool(key) as T;
		}
		if (defaultValue is String) {
			return getString(key) as T; // handle ourselves
		}
		throw Exception('No Implementation Found');
	}

	@override
	Future<void> setObject<T>(String key, T value) {
		print("setObject($key, $value)");
		if (value is int) {
			return prefs.setInt(key, value);
		}
		if (value is double) {
			return prefs.setDouble(key, value);
		}
		if (value is bool) {
			return prefs.setBool(key, value);
		}
		if (value is String) {
			return setString(key, value);	// Handle ourselves
		}
		throw Exception('No Implementation Found');
	}

	@override
	bool containsKey(String key) {
		print("SettingsCache::containsKey($key)");
		bool tmp;
		if (key == Constants.KEY_CODE) {
			storage.containsKey(key: Constants.KEY_CODE).then((v) { tmp = v; });
			print("containsKey($key) returning ${tmp??false}");
		  return tmp??false;
		} else {
			return prefs.containsKey(key);
		}
	}

  @override
  bool getBool(String key) {
    return prefs.getBool(key);
  }

  @override
  double getDouble(String key) {
    return prefs.getDouble(key);
  }

  @override
  int getInt(String key) {
		return prefs.getInt(key);
  }

  @override
  Set<E> getKeys<E>() {
    // TODO: implement getKeys
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // Nothing to do here?
  }

  @override
  Future<void> remove(String key) {
    if (key == Constants.KEY_CODE) {
			storage.delete(key: key);
		} else {
    	prefs.remove(key);
		}
  }

  @override
  Future<void> removeAll() {
    // We can't remove all as some keys are maintained by other parts of the app
		// We could remove all keys that are defined by us, if we had a list.
		throw UnimplementedError();
  }

  @override
  Future<void> setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int value) {
    prefs.setInt(key, value);
  }
}
