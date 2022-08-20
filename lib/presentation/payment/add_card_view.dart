import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String cardNumber = "0000 0000 0000 0000";
  String cardHolderName = AppStrings.nameHere;


  _bind() {
    _cardNumberController.addListener(() {
      cardNumber = _cardNumberController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
    return CardWidget(
      cardNumber: cardNumber,
      holderName: cardHolderName,
      expiredDate: _cardDateController.text,
      cvv: _cardCvvController.text,
    );
  }

  Widget _addCartDetailsSection() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _cardNumberTextFormField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: AppTextFormField(
                      _cardDateController,
                      const Icon(Icons.credit_card),
                      hasBorder: true,
                      hint: AppStrings.expiredDate,
                    )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                    child: AppTextFormField(
                  _cardCvvController,
                  const Icon(Icons.credit_card),
                  hasBorder: true,
                  hint: AppStrings.cvv,
                )),
              ],
            ),
        _cardHolderTextFormField(),
          ],
        ));
  }

  Widget _saveCardButtonSection() {
    return AppButton(AppStrings.saveCard, () {});
  }
  Widget _cardNumberTextFormField(){
    return TextFormField(
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      maxLength: 19,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CardNumberFormatter(),
      ],
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.credit_card),
        hintText: AppStrings.cardNumber,
        hintStyle: getTextStyle(
            AppColors.mainFontColor,
            AppFontSizes.f14,
            AppFontWeights.w3,
            AppSize.s1_5,
            AppSize.s1_5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
              width: AppSize.s1,
              color: AppColors.grey.withOpacity(AppDecimal.d_3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSize.s2,
            color: AppColors.primary.withOpacity(AppDecimal.d_3),
          ),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
      onChanged: (value) {
        setState(() {
          cardNumber = _cardNumberController.text;
        });
      },
    );

  }
  Widget _cardHolderTextFormField(){
    return TextFormField(
      controller: _cardholderNameController,
      decoration: InputDecoration(
        prefixIcon:const Icon(Icons.person),
        hintText: AppStrings.cardHolder,
        hintStyle: getTextStyle(
            AppColors.mainFontColor,
            AppFontSizes.f14,
            AppFontWeights.w3,
            AppSize.s1_5,
            AppSize.s1_5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
              width: AppSize.s1,
              color: AppColors.grey.withOpacity(AppDecimal.d_3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSize.s2,
            color: AppColors.primary.withOpacity(AppDecimal.d_3),
          ),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
      onChanged: (value) {
        setState(() {
          cardHolderName = _cardholderNameController.text;
        });
      },
    );

  }

}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
