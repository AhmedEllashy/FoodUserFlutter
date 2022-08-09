import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/app/app_prefs.dart';
import 'package:food_user/data/Repository/repository.dart';
import 'package:food_user/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/favourite_bloc/favourite_cubit.dart';
import 'package:food_user/domain/logic/product_bloc/product_cubit.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/theme_manager.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_)=>AuthCubit(_repository,_appPreferences)),
        BlocProvider<ProductCubit>(create: (_)=>ProductCubit(_repository)),
        BlocProvider<BannerCubit>(create: (_)=>BannerCubit(_repository)),
        BlocProvider<CartCubit>(create: (_)=>CartCubit(_repository),),
        BlocProvider<FavouriteCubit>(create: (_)=>FavouriteCubit(_repository),)

      ],
      child: MaterialApp(
        initialRoute: AppRoutes.paymentRoute,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
