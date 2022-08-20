import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_user/data/Data_source/remote_data_source.dart';
import 'package:food_user/data/Network/failure.dart';
import 'package:food_user/data/Network/network_info.dart';
import 'package:food_user/domain/models/cart.dart';
import 'package:food_user/domain/models/product.dart';
import 'package:geocoding/geocoding.dart';

import '../../domain/models/banner.dart';
import '../../domain/models/user.dart';
import '../Network/error_handler.dart';

abstract class Repository {
  Future signWithGoogle();
  Future signInWithEmailAndPassword(String email, String password);
  Future signUpWithEmailAndPassword(String email, String password);
  Future signInAnonymously();
  Future resetPassword(String email);
  Future<List<Product>> getAllProducts();
  Future<List<BannerModel>> getAllBanners();
  Future<dynamic> addToCart(String prodId,int quantity);
  Future<List<Cart>> getAllCartProducts();
  Future<dynamic> deleteFromCart(String prodId);
  Future<void> updateProductInCartQuantity(String uid,String prodId,int quantity);
  Future<void> setFavouriteProduct(String prodId);
  Future<dynamic> getAllFavouriteProducts();
  Future<void> deleteFavouriteProduct(String prodId);
  Future<void> addAddress(String name, String addressName, String phoneNumber,
      String country, String city, String detailsAboutAddress,double lat, double long);
  Future<Placemark> getLocation();
  Future<List<UserAddress>> getAllAddresses();
  Future<void> editAddress(List<UserAddress> addresses);
  Future<String> getDefaultAddress();
  Future<void> setDefaultAddress(String defaultAddress);

}

class RepositoryImplementer implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  RepositoryImplementer(this._networkInfo, this._remoteDataSource);
  @override
  Future signWithGoogle() async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.signWithGoogle();
    } else {
      throw (ErrorMessages.internetError);
    }
  }

  @override
  Future signInAnonymously() async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.signInAnonymously();
    } else {
      throw (ErrorMessages.internetError);
    }
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.signInWithEmailAndPassword(
          email, password);
    } else {
      throw (ErrorMessages.internetError);
    }
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.signUpWithEmailAndPassword(
          email, password);
    } else {
      throw (ErrorMessages.internetError);
    }
  }

  @override
  Future resetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.resetPassword(email);
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await _networkInfo.isConnected) {
      final products = await _remoteDataSource.getAllProducts();
      return products
          .map((product) => Product.fromFiresStore(product))
          .toList();
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<List<BannerModel>> getAllBanners() async {
    if (await _networkInfo.isConnected) {
      final banners = await _remoteDataSource.getAllBanners();
      return banners
          .map((banner) => BannerModel.fromFireStore(banner))
          .toList();
    } else {
      throw ErrorMessages.internetError;
    }
  }


  @override
  Future addToCart( String prodId, int quantity) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.addToCart(prodId, quantity);
    } else {
      throw ErrorMessages.internetError;
    }
  }
  @override
  Future<List<Cart>> getAllCartProducts() async {
    final cartProducts = await _remoteDataSource.getAllCartProducts();
    return cartProducts
        .map((cartProduct) =>
            Cart.fromFireStore(cartProduct["product"], cartProduct["quantity"]))
        .toList();
  }

  @override
  Future<void> updateProductInCartQuantity(String uid, String prodId, int quantity) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.updateProductInCartQuantity(uid, prodId, quantity);
    } else {
      throw ErrorMessages.internetError;
    }
  }
  @override
  Future deleteFromCart(String prodId) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.deleteFromCart(prodId);
    } else {
      throw ErrorMessages.internetError;
    }
  }
  @override


  @override
  Future<void> setFavouriteProduct( String prodId) async{
   await _remoteDataSource.setFavouriteProduct(prodId);
  }

  @override
  Future<List<dynamic>> getAllFavouriteProducts() async{
    if (await _networkInfo.isConnected) {
     final favouriteProducts =  await _remoteDataSource.getAllFavouriteProducts();
    return favouriteProducts.map((product)=>Product.fromJson(product)).toList();
    } else {
      throw ErrorMessages.internetError;
    }
  }
  @override
  Future<void> deleteFavouriteProduct(String prodId) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.deleteFavouriteProduct(prodId);
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<void> addAddress(String name, String addressName, String phoneNumber, String country, String city, String detailsAboutAddress,double lat,double long) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.addAddress(name, addressName, phoneNumber, country, city, detailsAboutAddress,lat,long);
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<Placemark> getLocation() async{
    if (await _networkInfo.isConnected) {
      final location = await _remoteDataSource.getLocation();
      return location;
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<List<UserAddress>> getAllAddresses() async{
    if (await _networkInfo.isConnected) {
      final addresses = await _remoteDataSource.getAllAddresses();
      return addresses;
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<void> editAddress(List<UserAddress> addresses)  async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.editAddress(addresses);
    } else {
      throw ErrorMessages.internetError;
    }
  }

  @override
  Future<String> getDefaultAddress() async{
    if (await _networkInfo.isConnected) {
      final defaultAddress =  await _remoteDataSource.getDefaultAddress();
      return defaultAddress;
    } else {
      throw ErrorMessages.internetError;
    }

  }

  @override
  Future<void> setDefaultAddress(String defaultAddress) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.setDefaultAddress(defaultAddress);
    } else {
      throw ErrorMessages.internetError;
    }
  }




}
