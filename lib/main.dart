import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll_system/core/network/api.dart';
import 'package:payroll_system/features/department/data/datasources/departmetn_data_source_impl.dart';
import 'package:payroll_system/features/department/data/datasources/designation_data_source_impl.dart';
import 'package:payroll_system/features/department/data/repositories/department_repository_impl.dart';
import 'package:payroll_system/features/department/data/repositories/designation_repository_impl.dart';
import 'package:payroll_system/features/department/domain/usecase/designations.dart';
import 'package:payroll_system/features/department/presentation/blocs/department_page_controller_cubit/department_page_controller_cubit.dart';
import 'package:payroll_system/features/department/presentation/blocs/departments_cubit/departments_cubit.dart';
import 'package:payroll_system/features/login/data/datasources/impl/login_data_source_impl.dart';
import 'package:payroll_system/features/login/data/repositories/login_repository_impl.dart';
import 'package:payroll_system/features/login/domain/usecases/login.dart';
import 'package:payroll_system/features/login/presentation/blocs/bloc/session_bloc.dart';
import 'package:payroll_system/features/system/presentation/blocs/system_tab/system_tab_cubit.dart';

import 'core/shared/app_router.dart';
import 'core/shared/app_theme.dart';
import 'core/shared/bloc_observer.dart';
import 'core/shared/strings.dart';
import 'core/utils/system_interaction_listener.dart';
import 'features/department/domain/usecase/departments.dart';
import 'features/department/presentation/blocs/designations_cubit/designations_cubit.dart';

const minSize = Size(1280, 720);

Future<void> main() async {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppObserver(),
  );
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = minSize;
      win.minSize = minSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Payroll Management";
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
    return ScreenUtilInit(
      designSize: minSize,
      minTextAdapt: true,
      builder: (context, child) {
        return RepositoryProvider(
          create: (context) => API(),
          child: MultiBlocProvider(
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
              BlocProvider(
                create: (context) => SystemTabCubit(),
              ),
              BlocProvider(
                create: (context) => DepartmentsCubit(Departments(
                    DepartmentRepositoryImpl(DepartmentDataSourceImpl()))),
              ),
              BlocProvider(
                create: (context) => DesignationsCubit(Designations(
                    DesignationRepositoryImpl(DesignationDatasourceImpl()))),
              ),
              BlocProvider(
                create: (context) => DepartmentPageControllerCubit(),
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
          ),
        );
      },
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
