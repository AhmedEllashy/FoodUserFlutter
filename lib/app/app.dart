import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_user/app/app_prefs.dart';
import 'package:food_user/data/Network/FirebaseMessgingHandler.dart';
import 'package:food_user/data/Repository/repository.dart';
import 'package:food_user/domain/logic/address_bloc/address_cubit.dart';
import 'package:food_user/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/chat_bloc/chat_cubit.dart';
import 'package:food_user/domain/logic/favourite_bloc/favourite_cubit.dart';
import 'package:food_user/domain/logic/notification_bloc/notification_cubit.dart';
import 'package:food_user/domain/logic/order_bloc/order_cubit.dart';
import 'package:food_user/domain/logic/payment_bloc/payment_cubit.dart';
import 'package:food_user/domain/logic/product_bloc/product_cubit.dart';
import 'package:food_user/domain/logic/user_bloc/user_cubit.dart';
import 'package:food_user/main.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/theme_manager.dart';
import '../data/Network/payment_api.dart';
import '../domain/logic/auth_bloc/auth_cubit.dart';
import 'di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
  final PaymentApi _paymentApi = instance<PaymentApi>();





  @override
  void initState() {
    super.initState();
    FirebaseMessagingHandler().initFirebaseNotificationApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_)=>AuthCubit(_repository,_appPreferences)),
        BlocProvider<ProductCubit>(create: (_)=>ProductCubit(_repository)),
        BlocProvider<BannerCubit>(create: (_)=>BannerCubit(_repository)),
        BlocProvider<CartCubit>(create: (_)=>CartCubit(_repository),),
        BlocProvider<FavouriteCubit>(create: (_)=>FavouriteCubit(_repository),),
        BlocProvider<AddressCubit>(create: (_)=>AddressCubit(_repository),),
        BlocProvider<OrderCubit>(create: (_)=>OrderCubit(_repository),),
        BlocProvider<PaymentCubit>(create: (_)=>PaymentCubit(_paymentApi),),
        BlocProvider<UserCubit>(create: (_)=>UserCubit(_repository),),
        BlocProvider<NotificationCubit>(create: (_)=>NotificationCubit(_repository),),
        BlocProvider<ChatCubit>(create: (_)=>ChatCubit(_repository),),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.splashRoute,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
