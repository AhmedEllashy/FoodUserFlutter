import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/data/Network/payment_api.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({Key? key}) : super(key: key);

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  final _cardFormFieldEditingController = CardFormEditController();
  CardFieldInputDetails ?_card ;
  String cardNumber = "";
  String cardHolderName = AppStrings.nameHere;

  @override
  void initState() {
    _cardFormFieldEditingController.addListener(update);

    super.initState();
  }
  void update() => setState(() {

  });

  @override
  void dispose() {
    _cardFormFieldEditingController.removeListener(update);
    _cardFormFieldEditingController.dispose();
    super.dispose();
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
                // _addCartDetailsSection(),
                CardField(
                  // controller: _cardFormFieldEditingController,
                  dangerouslyUpdateFullCardDetails: true,
                  dangerouslyGetFullCardDetails: true,
                  enablePostalCode: false,
                  onCardChanged: (card) {
                    print(card);
                    setState(() {
                      cardNumber = card?.number ?? "";
                    });
                  },
                ),
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
    );
  }

  Widget _saveCardButtonSection() {
    return AppButton(AppStrings.saveCard, () async{
    });
  }
}
