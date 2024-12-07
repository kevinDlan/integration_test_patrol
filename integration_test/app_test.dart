import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_basics_tutorial/main.dart';
import 'package:patrol_basics_tutorial/pages/integration_test_keys.dart';

void main() {
  patrolTest('signs in, triggers a notification, and tap on it',
      framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
      ($) async {
    initApp();
    await $.pumpWidgetAndSettle(const MainApp());
    await $(keys.signInPage.emailTextField).enterText("test@gmail.com");
    await $(keys.signInPage.passwordTextField).enterText("password");
    await $(keys.signInPage.signInButton).tap();
    if (await $.native.isPermissionDialogVisible()) {
      await $.native.grantPermissionWhenInUse();
    }

    await $(keys.homePage.notificationIcon).tap();
    await $.native.pressHome();
    await $.native.openNotifications();
    await $.native.tapOnNotificationBySelector(
      Selector(textContains: 'Patrol says hello!'),
      timeout: const Duration(
        seconds: 5,
      ),
    );

    await $(keys.homePage.successSnackbar).waitUntilVisible();

    // await $(TextField).finder.
    // await Future.delayed(const Duration(seconds: 2));
  });
}
