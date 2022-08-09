import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({Key? key}) : super(key: key);

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final _card = const CardField();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardDateController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardholderNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _topBarSection(),
                const SizedBox(
                  height: AppSize.s35,
                ),
                _cardSection(),
                const SizedBox(
                  height: AppSize.s35,
                ),
                _addCartDetailsSection(),
                const SizedBox(
                  height: AppSize.s35,
                ),
                _saveCardButtonSection(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBarSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //     Navigator.pop(context);
        // debugPrint('Tapped');
        Container(
          height: AppSize.s45,
          width: AppSize.s45,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              textDirection: TextDirection.ltr,
              size: AppSize.s18,
              color: AppColors.black,
            ),
          ),
        ),
        Text(
          AppStrings.addCard,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _cardSection() {
    return CardWidget();
  }

  Widget _addCartDetailsSection() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextFormField(
              _cardNumberController,
              const Icon(Icons.credit_card),
              hasBorder: true,
              hint: AppStrings.cardNumber,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: AppTextFormField(
                      _cardNumberController,
                      const Icon(Icons.credit_card),
                      hasBorder: true,
                      hint: AppStrings.expiredDate,
                    )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                    child: AppTextFormField(
                  _cardNumberController,
                  const Icon(Icons.credit_card),
                  hasBorder: true,
                  hint: AppStrings.cvv,
                )),
              ],
            ),
            AppTextFormField(
              _cardNumberController,
              const Icon(Icons.person),
              hasBorder: true,
              hint: AppStrings.cardHolder,
            ),
          ],
        ));
  }

  Widget _saveCardButtonSection(){
    return AppButton(AppStrings.saveCard, () { });

  }
}
