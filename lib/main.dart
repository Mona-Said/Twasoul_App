import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasoul/shared/bloc_observer.dart';
import 'package:twasoul/shared/components/components.dart';
import 'package:twasoul/shared/components/constants.dart';
import 'package:twasoul/shared/network/local/cache_helper.dart';
import 'package:twasoul/shared/styles/themes.dart';
import 'cubit/cubit.dart';
import 'firebase_options.dart';
import 'layout/social_layout_screen.dart';
import 'modules/social_login/social_login_screen.dart';
import 'notifications_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('onBackgroundMessage');
  print(message.data.toString());
  itemToast(text: 'onBackgroundMessage', state: ToastStates.success);
}

//social app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var tokenApp = await FirebaseMessaging.instance.getToken();
  //print(tokenApp);

  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    itemToast(text: 'on message', state: ToastStates.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened');
    print(event.data.toString());
    itemToast(text: 'on message opened', state: ToastStates.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  NotificationsHelper.getAccessToken();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocialLayoutScreen();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLayoutCubit()
        ..getUserData()
        ..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
