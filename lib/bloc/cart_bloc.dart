import 'package:flutter_week_14/bloc/cart_event.dart';
import 'package:flutter_week_14/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(badgeValue: 0)) {
    on<Add>((Add event, Emitter<CartState> emitter) {
      List<bool> list = state.productsList;
      list[event.index] = true;
      return emitter(CartState(
          productSelection: true,
          badgeValue: state.badgeValue + 1,
          message: 'Added to cart',
          productsList: list));
    });

    on<Remove>((Remove event, Emitter<CartState> emitter) {
      List<bool> list = state.productsList;
      list[event.index] = false;
      return emitter(CartState(
          productSelection: true,
          badgeValue: state.badgeValue - 1,
          message: 'Removed from cart',
          productsList: list));
    });
  }
}
