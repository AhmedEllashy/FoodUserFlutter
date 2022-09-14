import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/address_bloc/address_state.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../domain/logic/address_bloc/address_cubit.dart';
import '../../../domain/models/user.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class EditAddressView extends StatefulWidget {
  UserAddress address;
  int index;
  EditAddressView(this.address, this.index, {Key? key}) : super(key: key);

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addAddressNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressInDetailsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String defaultAddress = "";
  String prevDefaultAddress = "";
  bool isDefault = false;

  @override
  void initState() {
    _nameController.text = widget.address.name;
    _addAddressNameController.text = widget.address.addressName;
    _phoneNumberController.text = widget.address.phoneNumber;
    _countryController.text = widget.address.country;
    _cityController.text = widget.address.city;
    _addressInDetailsController.text = widget.address.detailsAboutAddress;
    Future.delayed(const Duration(milliseconds: 500), () async {
      defaultAddress = await AddressCubit.get(context).getDefaultAddress();
    setState((){
      isDefault = widget.index.toString() == defaultAddress ? true : false;
    });
      prevDefaultAddress = defaultAddress;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is EditAddressFailedState) {
              getFlashBar(state.error, context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppSize.s14),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      topBarSection(AppStrings.editAddress, context),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(_nameController, AppStrings.name),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(
                          _addAddressNameController, AppStrings.addAddress),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(
                          _phoneNumberController, AppStrings.phoneNumber),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(_countryController, AppStrings.country),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(_cityController, AppStrings.city),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _getCustomTextField(_addressInDetailsController,
                          AppStrings.moreDetailsAboutAddress,
                          maxLines: 4),
                      CheckboxListTile(
                          title: Text(
                            AppStrings.makeDefaultAddress,
                            style: getMediumTextStyle(
                                color: AppColors.secondaryFontColor),
                          ),
                          activeColor: AppColors.primary,
                          value: isDefault,
                          onChanged: (value) {
                            isDefault = !isDefault;
                              if (value != null && value == true) {
                                defaultAddress = widget.index.toString();
                              } else {
                                defaultAddress = prevDefaultAddress;
                              }
                          }),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      state is EditAddressLoadingState
                          ? const CircularProgressIndicator()
                          :  AppButton(AppStrings.updateAddress, () {
                        _updateAddress(state);
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getCustomTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return TextFormField(
      // initialValue: initialValue,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        // prefixIcon:const Icon(Icons.location_city,size: AppSize.s20,),
        hintText: hintText,
        hintStyle: getTextStyle(AppColors.mainFontColor, AppFontSizes.f14,
            AppFontWeights.w3, AppSize.s1_5, AppSize.s1_5),
        fillColor: AppColors.white,
        filled: true,

        contentPadding: const EdgeInsets.all(AppSize.s20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: const BorderSide(
            width: AppSize.s1,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSize.s2,
            color: AppColors.primary.withOpacity(AppDecimal.d_3),
          ),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
  void _updateAddress(AddressState state) {
    if (_formKey.currentState!.validate()) {
      AddressCubit.get(context).editAddress(
        widget.index,
        _nameController.text,
        _addAddressNameController.text,
        _phoneNumberController.text,
        _countryController.text,
        _cityController.text,
        _addressInDetailsController.text,
        widget.address.lat,
        widget.address.long,
      );
      AddressCubit.get(context).setDefaultAddress(defaultAddress);
    }
    setState(() {
      if (state is AddAddressCompletedState) {
        Navigator.pop(context);
      }
    });
  }

}
