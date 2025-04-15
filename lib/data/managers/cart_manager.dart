import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/services/cep_service.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/domain/models/cart_product_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class CartManager extends ChangeNotifier {
  List<CartProductModel> items = [];

  UserModel? currentUser;
  AddressModel? address;

  num productsPrice = 0.0;
  num? deliveryPrice;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isCartValid {
    if (items.isEmpty) return false;

    for (final item in items) {
      if (!item.hasStock) return false;
    }

    return true;
  }

  num get totalPrice => productsPrice + (deliveryPrice ?? 0.0);

  bool get isAddressValid => address != null && deliveryPrice != null;

  void addToCart(ProductModel product) {
    if (currentUser != null) {
      try {
        final existCartProduct = items.firstWhere((item) => item.isStackable(product));

        existCartProduct.increment();
      } catch (e) {
        final cartProduct = CartProductModel.fromProduct(product);

        cartProduct.addListener(_onItemUpdated);

        items.add(cartProduct);

        currentUser!.cartRef.add(cartProduct.toMap()).then((doc) => cartProduct.cartProductId = doc.id);

        _onItemUpdated();
      }
    }
  }

  Future<void> updateUser(UserManager userManager) async {
    items.clear();
    removeAddress();
    productsPrice = 0.0;
    currentUser = userManager.getCurrentUser;

    if (currentUser != null) {
      Future.wait([
        _loadCartItens(),
        _loadUserAddress(),
      ]);
    }
  }

  Future<void> _loadCartItens() async {
    if (currentUser != null) {
      final result = await currentUser!.cartRef.get();

      try {
        final cartProducts = result.docs
            .map((doc) async => CartProductModel.fromDocument(
                  doc.data() as Map<String, dynamic>,
                  cartProductId: doc.id,
                ))
            .toList();

        for (final cartProduct in cartProducts) {
          final item = await cartProduct;

          if (!items.contains(item)) {
            items.add(item..addListener(_onItemUpdated));

            item.notifyListerners();
          }
        }
      } catch (e) {
        log('ERRO AO CARREGAR O CARRINHO');
      }
    }
  }

  Future<void> _loadUserAddress() async {
    if (currentUser?.address != null &&
        await calculateDelivery(
          lat: currentUser!.address!.lat,
          long: currentUser!.address!.long,
        )) {
      address = currentUser!.address;

      notifyListeners();
    }
  }

  void _onItemUpdated() {
    productsPrice = 0.0;

    for (final cartProduct in List<CartProductModel>.from(items)) {
      if (cartProduct.quantity == 0) {
        _removeOfCart(cartProduct);
      } else {
        _updateCartProduct(cartProduct);
      }

      productsPrice += cartProduct.totalPrice;
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProductModel cartProduct) {
    if (currentUser != null && cartProduct.cartProductId != null) {
      currentUser!.cartRef.doc(cartProduct.cartProductId).update(cartProduct.toMap());
    }
  }

  void _removeOfCart(CartProductModel cartProduct) {
    if (currentUser != null) {
      currentUser!.cartRef.doc(cartProduct.cartProductId).delete();

      cartProduct.removeListener(_onItemUpdated);

      items.removeWhere((item) => item.cartProductId == cartProduct.cartProductId);

      notifyListeners();
    }
  }

  Future<void> getAddress(String cep) async {
    try {
      loading = true;

      final cepService = CepService();
      final cepAbertoAddress = await cepService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = AddressModel.fromCepAbertoAddress(cepAbertoAddress);
      }
    } catch (e) {
      return Future.error('CEP Inválido.');
    } finally {
      loading = false;
    }
  }

  Future<void> setAddress(AddressModel address) async {
    loading = true;
    this.address = address;

    final addressValid = await calculateDelivery(lat: address.lat, long: address.long);

    if (addressValid) {
      currentUser?.setAddress(address);

      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora da área de entrega!');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery({required double lat, required double long}) async {
    final doc = await firestore.doc('aux/delivery').get();

    if (doc.exists) {
      final double latStore = doc.data()!['lat'];
      final double longStore = doc.data()!['long'];
      final num maxKmStore = doc.data()!['maxKm'];

      final num basePrice = doc.data()!['base_price'];
      final num priceKm = doc.data()!['price_km'];

      final double distance = Geolocator.distanceBetween(lat, long, latStore, longStore);
      final double distanceInKm = distance / 1000;

      if (distanceInKm > maxKmStore) return false;

      deliveryPrice = basePrice + (distanceInKm * priceKm);

      return true;
    }

    return false;
  }
}
