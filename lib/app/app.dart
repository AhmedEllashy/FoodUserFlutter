import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/app/app_prefs.dart';
import 'package:food_user/data/Repository/repository.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/theme_manager.dart';

import '../domain/logic/auth_bloc/auth_cubit.dart';
import 'di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// import 'di.dart';
class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();

  factory MyApp()=> instance;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Repository _repository = instance<Repository>();
  final AppPreferences _appPreferences = instance<AppPreferences>();



  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_)=>AuthCubit(_repository,_appPreferences))
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.mainRoute,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
