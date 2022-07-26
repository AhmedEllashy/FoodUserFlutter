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
import '../../domain/logic/auth_bloc/auth_states.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
        child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is AuthSignWithGoogleSuccessState) {
            debugPrint('success');
          }
          if (state is AuthSignWithGoogleFailedState) {
            debugPrint(state.errorMessage);
            Flushbar(
              message: state.errorMessage,
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              backgroundColor: AppColors.error,
            ).show(context);
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
                    AppStrings.registrationDescription,
                    style: getRegularTextStyle(
                       color: AppColors.black.withOpacity(AppDecimal.d_6)),
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s50,
                  ),
                  getTextsForm(),

                  state is AuthSignUpWitheEmailAndPasswordLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                          AppStrings.register,
                          () {
                            signUp(state);
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
                       color: AppColors.black.withOpacity(AppDecimal.d_3)),
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      state is AuthSignUpWithGoogleLoadingState
                          ? const CircularProgressIndicator()
                          : AppButton(
                              AppStrings.google,
                              () {
                                AuthCubit.get(context).signUpWithGoogle();
                              },
                              radius: AppSize.s4,
                              width: AppSize.s150,
                              height: AppSize.s60,
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
                        AppStrings.facebook,
                        () {},
                        radius: AppSize.s4,
                        width: AppSize.s150,
                        height: AppSize.s60,
                        color: AppColors.backgroundColor,
                        textColor: AppColors.black,
                        hasIcon: true,
                        hasBorder: false,
                        icon: AppAssets.facebookIcon,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.hasAnyAccount,
                        style: getRegularTextStyle(
                          color:  AppColors.black.withOpacity(AppDecimal.d_5)),
                        // textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.loginRoute);
                        },
                        child: Text(
                          AppStrings.login,
                          style: getRegularTextStyle(color:AppColors.primary),
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
            Icons.email,
            hint: AppStrings.emailHint,
            label: AppStrings.email,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            _phoneController,
            Icons.phone,
            hint: AppStrings.phoneHint,
            label: AppStrings.phoneNumber,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            _passwordController,
            Icons.lock,
            hint: AppStrings.passwordHint,
            isPassword: true,
            label: AppStrings.password,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }

  void signUp(state) {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).signUpWithEmailAndPassword(_emailController.text,
          _passwordController.text, _phoneController.text);
      if (state is AuthSignUpWitheEmailAndPasswordCompletedState) {
        Navigator.pushNamed(context, AppRoutes.mainRoute);
      } else if (state is AuthSignUpWitheEmailAndPasswordFailedState) {
        showFlashBar(state.errorMessage, context);
      }
    }
  }
}
