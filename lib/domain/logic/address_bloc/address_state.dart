import 'package:geocoding/geocoding.dart';

import '../../models/user.dart';

abstract class AddressState{}

class AddressInitialState extends AddressState{}

class AddAddressCompletedState extends AddressState{}
class AddAddressLoadingState extends AddressState{}
class AddAddressFailedState extends AddressState{
  String error;
  AddAddressFailedState(this.error);
}

class EditAddressCompletedState extends AddressState{}
class EditAddressLoadingState extends AddressState{}
class EditAddressFailedState extends AddressState{
  String error;
  EditAddressFailedState(this.error);
}

class GetCurrentAddressCompletedState extends AddressState{
  Placemark location;
  GetCurrentAddressCompletedState(this.location);
}
class GetCurrentAddressLoadingState extends AddressState{}
class GetCurrentAddressFailedState extends AddressState{
  String error;
  GetCurrentAddressFailedState(this.error);
}
class GetAllAddressesCompletedState extends AddressState{
  List<UserAddress> addresses;
  GetAllAddressesCompletedState(this.addresses);
}
class GetAllAddressesLoadingState extends AddressState{}
class GetAllAddressesFailedState extends AddressState{
  String error;
  GetAllAddressesFailedState(this.error);
}