import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/address_bloc/address_cubit.dart';
import 'package:food_user/domain/models/user.dart';
import 'package:food_user/presentation/address/add_address/add_address_view.dart';
import 'package:food_user/presentation/address/edit_address/edit_address_view.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../domain/logic/address_bloc/address_states.dart';
import '../../resources/color_manager.dart';

class AllAddressesView extends StatefulWidget {
  const AllAddressesView({Key? key}) : super(key: key);

  @override
  State<AllAddressesView> createState() => _AllAddressesViewState();
}

class _AllAddressesViewState extends State<AllAddressesView> {
  bool isSelected = false;
  List<UserAddress> addresses = [];
  @override
  void initState() {
    AddressCubit.get(context).getAllAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_location_alt),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddAddressView(addresses: addresses)));
        },
      ),
      body: SafeArea(
        child: BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) {
            if (state is GetAllAddressesFailedState) {
              getFlashBar(state.error, context);
            }
            if (state is GetAllAddressesCompletedState) {
              setState(() {
                addresses = state.addresses;
              });
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppSize.s14),
              child: Column(
                children: [
                  topBarSection(AppStrings.allAddresses, context),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  state is GetAllAddressesCompletedState
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              addressWidget(state.addresses, index),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: AppSize.s12,
                              ),
                          itemCount: state.addresses.length)
                      : state is GetAllAddressesLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget addressWidget(List<UserAddress> addresses, int index) {
    return InkWell(
      onTap: () {
        debugPrint("$index");
      },
      child: Container(
        height: AppSize.s100,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.location_on_rounded,
                color: AppColors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(AppSize.s3),
              child: Text(
                addresses[index].addressName,
                style: getMediumTextStyle(),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(AppSize.s4),
              child: Text(
                addresses[index].detailsAboutAddress,
                style: getRegularTextStyle(),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.edit_location_alt_outlined,
                color: AppColors.primary,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => EditAddressView(
                              addresses[index],
                          index,
                            )));
              },
            ),
          ),
        ),
      ),
    );
  }
}
