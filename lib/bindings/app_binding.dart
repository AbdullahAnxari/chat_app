import '../lib.dart';

class AppBinding extends Binding {
  List<Bind> binds = [
    Bind.put(HomeController()),
    Bind.put(SettingController()),
  ];
  @override
  List<Bind> dependencies() {
    return binds;
  }
}
