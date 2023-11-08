import 'package:flutter_block/screen/login_screen.dart';
import 'package:go_router/go_router.dart';


// https://blog.codefactory.ai/ -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return const LoginScreen();
        }),
  ],
);