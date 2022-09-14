import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../domain/logic/auth_bloc/auth_cubit.dart';
import '../../domain/logic/auth_bloc/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return getContentScreen();
  }

  Widget getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthSignWithGoogleSuccessState) {
            debugPrint('success');
          }
          if (state is AuthSignWithGoogleFailedState) {
            debugPrint(state.errorMessage);
            getFlashBar(state.errorMessage, context);
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s60),
                    child: Text(
                      AppStrings.registrationTitle,
                      style: getBoldTextStyle(fontSize: AppFontSizes.f25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    AppStrings.loginDescription,
                    style: getRegularTextStyle(
                        color :AppColors.black.withOpacity(AppDecimal.d_6)),
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s50,
                  ),
                  getTextsForm(),
                state is AuthSignInWitheEmailAndPasswordLoadingState?const CircularProgressIndicator():  AppButton(
                    AppStrings.login,
                    () {
                      login(state);
                    },
                    height: AppSize.s60,
                    radius: AppSize.s30,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    AppStrings.or,
                    style: getRegularTextStyle(
                        color : AppColors.black.withOpacity(AppDecimal.d_3)),
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  state is AuthSignWithGoogleLoadingState
                      ? const CircularProgressIndicator()
                      : AppButton(
                          AppStrings.signInWithGoogle,
                          () {
                            AuthCubit.get(context).signInWithGoogle();
                          },
                          radius: AppSize.s4,
                          color: AppColors.backgroundColor,
                          textColor: AppColors.black,
                          hasIcon: true,
                          hasBorder: false,
                          icon: AppAssets.googleIcon,
                        ),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  AppButton(
                    AppStrings.signInWithFaceBook,
                    () {},
                    radius: AppSize.s4,
                    color: AppColors.backgroundColor,
                    textColor: AppColors.black,
                    hasIcon: true,
                    hasBorder: false,
                    icon: AppAssets.facebookIcon,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.doesNotHaveAnyAccount,
                        style: getRegularTextStyle(
                            color :AppColors.black.withOpacity(AppDecimal.d_5)),
                        // textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerRoute);
                        },
                        child: Text(
                          AppStrings.register,
                          style: getRegularTextStyle( color:AppColors.primary),
                          // textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget getTextsForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            _emailController,
            const Icon(Icons.email),
            hint: AppStrings.emailHint,
            label: AppStrings.email,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            _passwordController,
            const Icon(Icons.lock),
            hint: AppStrings.passwordHint,
            isPassword: true,
            label: AppStrings.password,
          ),
          TextButton(
            onPressed: () {
              _formKey.currentState!.validate();
              AuthCubit.get(context).restPassword(_emailController.text);
            },
            child: Text(
              AppStrings.forgotPassword,
              style: getRegularTextStyle(color :AppColors.primary),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }

  void login(state) {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
       if (state is AuthSignInWitheEmailAndPasswordFailedState) {
        getFlashBar(state.errorMessage, context);
      }else{
         Navigator.pushNamed(context, AppRoutes.mainRoute);

       }
    }
  }
}
