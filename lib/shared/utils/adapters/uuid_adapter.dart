import 'package:uuid/uuid.dart';

abstract class UuidAdapter {
  String createId();
}

class UuidAdapterImpl implements UuidAdapter {
  @override
  String createId() {
    return const Uuid().v4();
  }
}
