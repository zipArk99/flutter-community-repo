import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_reddit/models/user.dart";
import "package:flutter_reddit/router.dart";
import "package:flutter_reddit/services/auth/controller/auth_controller.dart";
import "package:flutter_reddit/services/auth/screen/login_screen.dart";
import "package:flutter_reddit/theme/pallete.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:routemaster/routemaster.dart";

import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, String userId) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserDataById(userId)
        .first;

    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (user) {
        return MaterialApp.router(
          routeInformationParser: const RoutemasterParser(),
          routerDelegate: RoutemasterDelegate(routesBuilder: (contx) {
            if (user != null) {
              getData(ref, user.uid);
              if (userModel != null) {
                return loggedInRoute;
              }
            } 
            return loggedOutRoute;
          
          }),
          title: "Reddit",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,
          ),
        );
      },
      error: (error, StackTrace) {
        return Text(
          error.toString(),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
