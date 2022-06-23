import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_system/features/login/data/datasources/impl/login_data_source_impl.dart';
import 'package:payroll_system/features/login/data/repositories/login_repository_impl.dart';
import 'package:payroll_system/features/login/domain/usecases/login.dart';
import 'package:payroll_system/features/login/presentation/blocs/bloc/session_bloc.dart';

import 'core/shared/app_router.dart';
import 'core/shared/app_theme.dart';
import 'core/shared/strings.dart';
import 'core/utils/system_interaction_listener.dart';
import 'features/number_trivia/presentation/shared/bloc_observer.dart';

Future<void> main() async {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppObserver(),
  );
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      const minSize = Size(1280, 720);
      const initialSize = minSize;
      win.minSize = minSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Youth HRM";
      win.show();
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionBloc(
            Login(
              LoginRepositoryImpl(
                LoginDataSourceImpl(),
              ),
            ),
          ),
        ),
      ],
      child: SystemInteractionListner(
        onInteraction: () {},
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: appTheme,
          onGenerateRoute: AppRouter().onGenerateRoute,
          initialRoute: Routes.login.name,
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   NumberTriviaRepositoryImpl _getRepo() {
//     return NumberTriviaRepositoryImpl(
//       localDataSource: NumberTriviaDataSourceImpl(null),
//       remoteDataSource: NumberTriviaRemoteDataSourceImpl(http.Client()),
//       networkInfo: NetworkInfoImpl(
//         DataConnectionChecker(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NumberTriviaBloc(
//         getConcreteNumberTrivia: GetConcreteNumberTrivia(
//           _getRepo(),
//         ),
//         getRandomNumberTrivia: GetRandomNumberTrivia(
//           _getRepo(),
//         ),
//         inputConverter: InputConverter(),
//       ),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const Home(),
//       ),
//     );
//   }
// }
