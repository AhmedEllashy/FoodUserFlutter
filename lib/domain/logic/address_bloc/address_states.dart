import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';

import '../../models/user.dart';

abstract class AddressStates{}

class AddressInitialState extends AddressStates{}

class AddAddressCompletedState extends AddressStates{}
class AddAddressLoadingState extends AddressStates{}
class AddAddressFailedState extends AddressStates{
  String error;
  AddAddressFailedState(this.error);
}

class EditAddressCompletedState extends AddressStates{}
class EditAddressLoadingState extends AddressStates{}
class EditAddressFailedState extends AddressStates{
  String error;
  EditAddressFailedState(this.error);
}

class GetCurrentAddressCompletedState extends AddressStates{
  Placemark location;
  GetCurrentAddressCompletedState(this.location);
}
class GetCurrentAddressLoadingState extends AddressStates{}
class GetCurrentAddressFailedState extends AddressStates{
  String error;
  GetCurrentAddressFailedState(this.error);
}
class GetAllAddressesCompletedState extends AddressStates{
  List<UserAddress> addresses;
  GetAllAddressesCompletedState(this.addresses);
}
class GetAllAddressesLoadingState extends AddressStates{}
class GetAllAddressesFailedState extends AddressStates{
  String error;
  GetAllAddressesFailedState(this.error);
}