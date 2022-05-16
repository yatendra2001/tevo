import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tevo/blocs/blocs.dart';
import 'package:tevo/screens/login/auth_screen.dart';
import 'package:tevo/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prevState, state) =>
            prevState.status == AuthStatus.unknown ||
            (prevState.status == AuthStatus.unauthenticated &&
                state.status ==
                    AuthStatus
                        .authenticated), // Run on first launch OR on sign up/in.
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.of(context).pushNamed(AuthScreen.routeName);
          } else if (state.status == AuthStatus.authenticated &&
              state.isUserExist == true) {
            Navigator.of(context).pushNamed(NavScreen.routeName);
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
