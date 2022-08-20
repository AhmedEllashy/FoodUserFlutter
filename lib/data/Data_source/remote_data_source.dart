import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_user/data/Network/auth_api.dart';
import 'package:food_user/data/Network/location_api.dart';
import 'package:geocoding/geocoding.dart';

import '../../domain/models/user.dart';
import '../Network/app_api.dart';

abstract class RemoteDataSource {
  Future signWithGoogle();
  Future signInWithEmailAndPassword(String email, String password);
  Future signUpWithEmailAndPassword(String email, String password);
  Future signInAnonymously();
  Future resetPassword(String email);

  Future<List<dynamic>> getAllProducts();
  Future<List<dynamic>> getAllBanners();
  Future<dynamic> addToCart( String prodId,int quantity);
  Future<List<dynamic>> getAllCartProducts();
  Future<dynamic> deleteFromCart(String prodId);
  Future<void> updateProductInCartQuantity(String uid,String prodId,int quantity);
  Future<void> setFavouriteProduct(String prodId);
  Future<List<dynamic>> getAllFavouriteProducts();
  Future<void> deleteFavouriteProduct(String prodId);
  Future<void> addAddress(String name, String addressName, String phoneNumber,
      String country, String city, String detailsAboutAddress,double lat, double long);
  Future<Placemark> getLocation();
  Future<List<UserAddress>> getAllAddresses();
  Future<void> editAddress(List<UserAddress> addresses);
  Future<String> getDefaultAddress();
  Future<void> setDefaultAddress(String defaultAddress);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AuthApi _authApi;
  final AppServiceClient _appServiceClient;
  final LocationManager _location;

  RemoteDataSourceImplementer(this._authApi, this._appServiceClient,this._location);

  @override
  Future signWithGoogle() async {
    return await _authApi.signWithGoogle();
  }

  @override
  signInAnonymously() async {
    return await _authApi.signInAnonymously();
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    return await _authApi.signInWithEmailAndPassword(email, password);
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password) async {
    return await _authApi.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future resetPassword(email) async {
    await _authApi.resetPassword(email: email);
  }

  @override
  Future<List<dynamic>>
      getAllProducts() async {
    final products = await _appServiceClient
        .getAllPopularProducts();
    return products;
  }

  @override
  Future<List> getAllBanners() async{
    final banners = await _appServiceClient.getAllBanners();
    return banners;

  }

  @override
  Future<dynamic> addToCart(String prodId,int quantity) async{
    await _appServiceClient.addToCart(prodId, quantity);
  }

  @override
  Future<List> getAllCartProducts() async{
    final cartProducts = await _appServiceClient.getAllCartProducts();
    return cartProducts;
  }
  @override
  Future deleteFromCart(String prodId) async{
    await _appServiceClient.deleteFromCart(prodId);
  }
  @override
  Future<void> updateProductInCartQuantity(String uid, String prodId, int quantity) async{
    await _appServiceClient.updateProductInCartQuantity(uid, prodId, quantity);
  }

  @override
  Future<void> setFavouriteProduct( String prodId) async{
   await _appServiceClient.setFavouriteProduct( prodId);
  }

  @override
  Future<List<dynamic>> getAllFavouriteProducts() async{
   final favouriteProducts = await _appServiceClient.getAllFavouriteProducts();
   return favouriteProducts;
  }

  @override
  Future<void> deleteFavouriteProduct(String prodId) async{
   await _appServiceClient.deleteFavouriteProduct(prodId);
  }

  @override
  Future<void> addAddress(String name, String addressName, String phoneNumber, String country, String city, String detailsAboutAddress,double lat ,double long) async{
    await _appServiceClient.addAddress(name, addressName, phoneNumber, country, city, detailsAboutAddress,lat,long);
  }

  @override
  Future<Placemark> getLocation()async{
    final location = await _location.getGeoLocation();
    return location;
  }

  @override
  Future<List<UserAddress>> getAllAddresses() async{
    final addresses = await _appServiceClient.getAllAddresses();
    return addresses;
  }

  @override
  Future<void> editAddress(List<UserAddress> addresses)  async{
    await _appServiceClient.editAddress(addresses);
  }

  @override
  Future<String> getDefaultAddress() async{
     final defaultAddress = await _appServiceClient.getDefaultAddress();
     return defaultAddress;
  }

  @override
  Future<void> setDefaultAddress(String defaultAddress) async{
    await _appServiceClient.setDefaultAddress(defaultAddress);
  }





}
