import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_user/presentation/address/add_address/add_address_view.dart';
import 'package:food_user/presentation/address/all_addresses/all_addresses_view.dart';
import 'package:food_user/presentation/address/edit_address/edit_address_view.dart';
import 'package:food_user/presentation/check_out/check_out_view.dart';
import 'package:food_user/presentation/login/login_view.dart';
import 'package:food_user/presentation/main/pages/cart/cart_view.dart';
import 'package:food_user/presentation/main/pages/favourite/favourite_view.dart';
import 'package:food_user/presentation/main/pages/notification/notification_view.dart';
import 'package:food_user/presentation/main/pages/profile/profile_view.dart';
import 'package:food_user/presentation/onboarding/onboarding_view.dart';
import 'package:food_user/presentation/order/orders_view/orders_view.dart';
import 'package:food_user/presentation/payment/add_card_view.dart';
import 'package:food_user/presentation/pre_login/pre_login_view.dart';
import 'package:food_user/presentation/product_details/product_details_view.dart';
import 'package:food_user/presentation/registration/registration_view.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/splash/spalsh_view.dart';
import 'package:food_user/presentation/success_order/success_order_view.dart';

import '../main/main_view.dart';
import '../most_popular_products/most_popular_products.dart';


class AppRoutes{
  static const String splashRoute= '/splash';
  static const String mainRoute= '/main';
  static const String loginRoute= '/login';
  static const String registerRoute= '/register';
  static const String onBoardingRoute= '/onBoarding';
  static const String productDetailsRoute= '/productDetails';
  static const String preLoginRoute= '/preLogin';
  static const String cartRoute= '/cart';
  static const String notificationRoute= '/notification';
  static const String favouriteRoute= '/favourite';
  static const String profileRoute= '/profile';
  static const String mostPopularRoute= '/mostPopular';
  static const String addCardRoute= '/addCard';
  static const String editCardRoute= '/editCard';
  static const String allCardsRoute= '/allCards';
  static const String checkOutRoute= '/checkOut';
  static const String successRoute= '/success';
  static const String addAddressRoute= '/addAddress';
  static const String editAddressRoute= '/editAddress';
  static const String allAddressesRoute= '/allAddresses';
  static const String ordersRoute= '/orders';










}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.mainRoute :
          return MaterialPageRoute(builder:(context)=>const MainView());
      case AppRoutes.notificationRoute :
        return MaterialPageRoute(builder:(context)=>const NotificationView());
      case AppRoutes.favouriteRoute :
        return MaterialPageRoute(builder:(context)=>const FavouriteView());
      case AppRoutes.profileRoute :
        return MaterialPageRoute(builder:(context)=>const ProfileView());
      case AppRoutes.cartRoute :
        return MaterialPageRoute(builder:(context)=>  const CartView());
    case AppRoutes.loginRoute :
        return MaterialPageRoute(builder:(context)=>  const LoginView());
      case AppRoutes.productDetailsRoute :
        return MaterialPageRoute(builder:(context)=>   ProductDetailsView());
      case AppRoutes.mostPopularRoute :
        return MaterialPageRoute(builder:(context)=>  const MostPopularProductsView());
      case AppRoutes.registerRoute :
        return MaterialPageRoute(builder:(context)=> const RegistrationView());
      case AppRoutes.splashRoute :
        return MaterialPageRoute(builder:(context)=>const SplashView());
      case AppRoutes.onBoardingRoute :
        return MaterialPageRoute(builder:(context)=>const OnBoardingView());
      case AppRoutes.preLoginRoute :
        return MaterialPageRoute(builder:(context)=>const PreLoginView());
      case AppRoutes.addCardRoute :
        return MaterialPageRoute(builder:(context)=>const AddCardView());
      case AppRoutes.checkOutRoute :
        return MaterialPageRoute(builder:(context)=> CheckOutView());
      case AppRoutes.successRoute :
        return MaterialPageRoute(builder:(context)=> const SuccessOrderView());
      case AppRoutes.allAddressesRoute :
        return MaterialPageRoute(builder:(context)=> const AllAddressesView());
      case AppRoutes.ordersRoute :
        return MaterialPageRoute(builder:(context)=> const OrdersView());

        default:
          return undefinedRoute();

    }
  }

  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (context)=> const Scaffold(
      body: Text(AppStrings.errorRoute),
    ));
  }
}