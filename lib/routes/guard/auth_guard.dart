import 'package:auto_route/auto_route.dart';
import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/store/store.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    String? loggedIn = await SecureStorage.read('token');
    if (loggedIn != null) {
      resolver.next(true);
    } else {
      router.push(LoginRoute(onResult: (result) async {
        // if true then go to desired route
        if (result == true) {
          // goto specified route
          resolver.next(true);
          // remove login screen from route
          router.removeLast();
        }
        // else stay at login route
      }));
    }
  }
}
