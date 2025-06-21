import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  FirebaseRemoteConfig config = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await config.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 15),
      ),
    );

    await config.fetchAndActivate();
  }

  Future<RemoteConfigValue> get(String key) async {
    await config.fetch();

    return config.getValue(key);
  }
}
