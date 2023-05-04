import 'package:provider/provider.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';

class AuthService {
  static bool loggedIn(context) {
    final appState = Provider.of<AppState>(context, listen: true);
    return appState.loggedIn;
  }
}
