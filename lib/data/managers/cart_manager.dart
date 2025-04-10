import 'dart:developer';

import 'package:flutter/material.dart';
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

  bool get isCartValid {
    if (items.isEmpty) return false;

    for (final item in items) {
      if (!item.hasStock) return false;
    }

    return true;
  }

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
    currentUser = userManager.getCurrentUser;
    items.clear();

    if (currentUser != null) {
      await _loadCartItens();
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
      final cepService = CepService();
      final cepAbertoAddress = await cepService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = AddressModel.fromCepAbertoAddress(cepAbertoAddress);

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
