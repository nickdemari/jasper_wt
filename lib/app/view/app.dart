import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jasper_wt/app/bloc/weight_logs/weight_logs_bloc.dart';
import 'package:jasper_wt/data/repositories/log_repository.dart';
import 'package:jasper_wt/presentation/login/cubit/login_cubit.dart';
import '../../data/repositories/authentication_repository.dart';

import '../../presentation/home/view/home_page.dart';
import '../../presentation/login/view/login_page.dart';
import '../../theme.dart';
import '../../utils/global_keys.dart';
import '../bloc/authentication/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required LogRepository logRepository,
  })  : _authenticationRepository = authenticationRepository,
        _logRepository = logRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final LogRepository _logRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc(
            authenticationRepository: _authenticationRepository,
          ),
        ),
        BlocProvider<WeightLogsBloc>(
          create: (context) => WeightLogsBloc(
            logRepository: _logRepository,
          ),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
            _authenticationRepository,
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _navigator?.pushAndRemoveUntil<void>(
                    HomePage.route(),
                    (route) => false,
                  );
                });
                break;
              case AppStatus.unauthenticated:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _navigator?.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                });
                break;
              default:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _navigator?.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                });
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => LoginPage.route(),
    );
  }
}
