import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/address_bloc/address_state.dart';
import 'package:food_user/domain/models/user.dart';

import '../../../data/Repository/repository.dart';

class AddressCubit extends Cubit<AddressState> {
  final Repository _repository;
  AddressCubit(this._repository) : super(AddressInitialState());
  static AddressCubit get(context) => BlocProvider.of<AddressCubit>(context);
  List<UserAddress> addresses = [];
  void addAddress(
      String name,
      String addressName,
      String phoneNumber,
      String country,
      String city,
      String detailsAboutAddress,
      double lat,
      double long) {
    emit(AddAddressLoadingState());
    _repository
        .addAddress(name, addressName, phoneNumber, country, city,
            detailsAboutAddress, lat, long)
        .then((_) {
      emit(AddAddressCompletedState());
    }, onError: (e) => emit(AddAddressFailedState(e.toString())));
  }

   editAddress(
      int index,
      String name,
      String addressName,
      String phoneNumber,
      String country,
      String city,
      String detailsAboutAddress,
      double lat,
      double long) async{
    emit(EditAddressLoadingState());
    final userAddresses = await _repository.getAllAddresses();
    userAddresses[index] = UserAddress(
        name: name,
        phoneNumber: phoneNumber,
        addressName: addressName,
        city: city,
        country: country,
        detailsAboutAddress: detailsAboutAddress,
        lat: lat,
        long: long);
    _repository.editAddress(userAddresses).then((_) {
      emit(EditAddressCompletedState());
    }, onError: (e) => emit(EditAddressFailedState(e.toString())));
  }

  void getCurrentLocation() {
    emit(GetCurrentAddressLoadingState());
    _repository.getLocation().then((location) {
      emit(GetCurrentAddressCompletedState(location));
    }, onError: (error) {
      emit(GetCurrentAddressFailedState(error.toString()));
    });
  }

  List<UserAddress> getAllAddresses() {
    emit(GetAllAddressesLoadingState());
    _repository.getAllAddresses().then((allAddresses) {
      addresses = allAddresses;
      emit(GetAllAddressesCompletedState(allAddresses));
    }, onError: (error) {
      emit(GetCurrentAddressFailedState(error.toString()));
    });
    return addresses;
  }

  Future<String> getDefaultAddress() {
    final defaultAddress = _repository.getDefaultAddress();
    return defaultAddress;
  }

  void setDefaultAddress(String defaultAddress) {
    _repository.setDefaultAddress(defaultAddress);
  }
}
