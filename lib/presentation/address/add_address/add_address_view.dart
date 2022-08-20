import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/data/Network/location_api.dart';
import 'package:food_user/domain/logic/address_bloc/address_cubit.dart';
import 'package:food_user/domain/logic/address_bloc/address_states.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/di.dart';
import '../../../domain/models/user.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class AddAddressView extends StatefulWidget {
  List<UserAddress> addresses ;
   AddAddressView({Key? key,required this.addresses}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addAddressNameController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressInDetailsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final locationApi = instance<LocationManager>();
  Position? _position;
  bool isDefault = false;
  String defaultAddress = "";
  String prevDefaultAddress = "";

  @override
  void initState() {
    AddressCubit.get(context).getCurrentLocation();
    Future.delayed(const Duration(milliseconds: 500), () async {
      defaultAddress = await AddressCubit.get(context).getDefaultAddress();
      prevDefaultAddress = defaultAddress;
      _position = await locationApi.getAddressLatLong();
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
        child: BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) {
            if (state is AddAddressFailedState) {
              getFlashBar(state.error, context);
            }
            if (state is GetCurrentAddressCompletedState) {
              final location = state.location;
              setState(() {
                _addressInDetailsController.text = location.street ?? "";
                _countryController.text = location.country ?? "";
              });
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
                      topBarSection(AppStrings.addAddress, context),
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
                      _getCustomTextField(
                          _countryController, AppStrings.country),
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
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      CheckboxListTile(
                          title: Text(
                            AppStrings.makeDefaultAddress,
                            style: getMediumTextStyle(
                                color: AppColors.secondaryFontColor),
                          ),
                          activeColor: AppColors.primary,
                          value: isDefault,
                          onChanged: (value){
                            isDefault = !isDefault;
                            setState(() {
                              if (value != null && value == true) {
                                defaultAddress = widget.addresses.length.toString();

                              }else{
                                defaultAddress = prevDefaultAddress;
                              }
                            });
                          }),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      state is AddAddressLoadingState
                          ? const CircularProgressIndicator()
                          : AppButton(AppStrings.addAddress, () {
                              _uploadAddress(state);
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
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppStrings.fieldRequired;
        } else {
          return null;
        }
      },
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

  void _uploadAddress(AddressStates state) {
    if (_formKey.currentState!.validate()) {
      AddressCubit.get(context).addAddress(
        _nameController.text,
        _addAddressNameController.text,
        _phoneNumberController.text,
        _countryController.text,
        _cityController.text,
        _addressInDetailsController.text,
        _position?.latitude ?? 0.0,
        _position?.longitude ?? 0.0,
      );
      AddressCubit.get(context).setDefaultAddress(defaultAddress);
    }
    setState(() {
      if (state is AddAddressCompletedState) {
        _nameController.clear();
        _addAddressNameController.clear();
        _phoneNumberController.clear();
        _cityController.clear();
        _countryController.clear();
        _addressInDetailsController.clear();
      }
    });
  }
}
