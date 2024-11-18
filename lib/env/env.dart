import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WEB_API_KEY')
  static const String webApiKey = _Env.webApiKey;

  @EnviedField(varName: 'ANDROID_API_KEY')
  static const String androidApiKey = _Env.androidApiKey;

  @EnviedField(varName: 'IOS_API_KEY')
  static const String iosApiKey = _Env.iosApiKey;
}
