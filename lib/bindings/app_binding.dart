import '../lib.dart';

class AppBinding extends Binding {
  List<Bind> binds = [
    Bind.put(HomeController()),
  ];
  @override
  List<Bind> dependencies() {
    return binds;
  }
}
