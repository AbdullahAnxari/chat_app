
import '../lib.dart';

class ThemProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme; //default

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
