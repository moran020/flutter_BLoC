import 'package:flutter_week_14/home_page.dart';

class CartState {
  final bool productSelection;
  final int badgeValue;
  final String message;
  final List<bool> productsList;

  CartState(
      {this.productSelection = false,
      required this.badgeValue,
      this.message = '',
      productsList})
      : productsList = productsList ?? List<bool>.filled(productsNumber, false);
}
