import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_14/bloc/cart_bloc.dart';
import 'package:flutter_week_14/bloc/cart_event.dart';
import 'package:flutter_week_14/bloc/cart_state.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(),
      child: const ProductList(),
    );
  }
}

int productsNumber = 16;

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        builder: (context, CartState value) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shopping App',
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
            actions: <Widget>[
              BlocConsumer<CartBloc, CartState>(
                  listenWhen: (CartState previous, CartState current) {
                if (current.productSelection == true) {
                  return true;
                } else {
                  return false;
                }
              }, listener: (context, CartState state) {
                final snackBar = SnackBar(
                    duration: const Duration(milliseconds: 500),
                    content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBar,
                );
              }, builder: (context, CartState productsState) {
                return Badge(
                  position: BadgePosition.topEnd(top: 0, end: 3),
                  animationDuration: const Duration(milliseconds: 300),
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    '${value.badgeValue}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                      icon: const Icon(Icons.shopping_cart), onPressed: () {}),
                );
              }),
            ],
          ),
          body: ListView.builder(
            itemCount: productsNumber,
            itemBuilder: (context, index) {
              return BlocBuilder<CartBloc, CartState>(
                  builder: (context, CartState cartState) {
                return Card(
                    child: ListTile(
                  title: Text(
                    'Product $index',
                    style: const TextStyle(fontSize: 20),
                  ),
                  leading: GestureDetector(
                      child: Icon(Icons.shopping_bag_outlined,
                          size: 40,
                          color: Colors
                              .primaries[index % Colors.primaries.length])),
                  trailing: Icon((cartState.productsList)[index]
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined),
                  onTap: () {
                    if ((cartState.productsList)[index]) {
                      context.read<CartBloc>().add(Remove(index: index));
                    } else {
                      context.read<CartBloc>().add(Add(index: index));
                    }
                  },
                ));
              });
            },
          ));
    });
  }
}
