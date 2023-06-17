import 'package:application/MyWidgets/product_details_rating_view.dart';
import 'package:application/MyWidgets/product_image_carousel.dart';
import 'package:application/constants.dart';
import 'package:application/models/product_details_model.dart';
import 'package:application/product_details/product_details_cubit.dart';
import 'package:application/product_details/product_details_state.dart';
import 'package:application/registration/authentication/auth_cubit.dart';
import 'package:application/registration/authentication/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/fragments/cart_fragment/cart_fragment.dart';
import '../home/fragments/cart_fragment/cart_fragment_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Options? selectedOption;

  @override
  Widget build(BuildContext context) {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductDetailsLoaded) {
            if (selectedOption == null) {
              selectedOption = state.model.options![0];
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          title: Text('Product Details'),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          actions: [
                            IconButton(
                                onPressed: () {
                                  if (authState is Authenticated) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .updateWishlist(
                                            selectedOption!.id!,
                                            authState.userdata.wishlist!
                                                    .contains(
                                                        selectedOption!.id!)
                                                ? REMOVE
                                                : ADD)
                                        .then((value) {
                                      if (value == SUCCESS) {
                                        setState(() {
                                          //nothing
                                        });
                                      } else if (value == FAILED) {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      }
                                    });
                                  }
                                },
                                icon: Icon(authState is Authenticated
                                    ? authState.userdata.wishlist!
                                            .contains(selectedOption!.id!)
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_border
                                    : Icons.favorite_border),
                                color: authState is Authenticated
                                    ? authState.userdata.wishlist!
                                            .contains(selectedOption!.id!)
                                        ? Colors.red
                                        : Colors.black
                                    : Colors.black),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.shopping_cart)),
                          ],
                        ),
                        ProductImageCarousel(selectedOption!.images!
                            .map((image) => image.image!)
                            .toList()),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.model.title!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Rs. " + state.model.offerPrice!.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rs. " + state.model.price!.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Options",
                                style: TextStyle(),
                              ),
                              DropdownButton<Options>(
                                  isExpanded: true,
                                  value: selectedOption,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  style: const TextStyle(color: Colors.purple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (Options? newValue) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      selectedOption = newValue!;
                                    });
                                  },
                                  items: state.model.options!
                                      .map<DropdownMenuItem<Options>>(
                                          (Options option) {
                                    return DropdownMenuItem<Options>(
                                      value: option,
                                      child: Text(option.option!),
                                    );
                                  }).toList()),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(state.model.description!),
                              SizedBox(
                                height: 16,
                              ),
                              ProductDetailsRatingView(
                                state.model.star5!,
                                state.model.star4!,
                                state.model.star3!,
                                state.model.star2!,
                                state.model.star1!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 0.5)
                  ]),
                  child: Row(
                    children: selectedOption!.quantity! > 0
                        ? [
                            Expanded(
                                child: TextButton(
                              child: Text(
                                authState is Authenticated
                                    ? authState.userdata.cart!
                                            .contains(selectedOption!.id!)
                                        ? "Remove"
                                        : "Add to Cart"
                                    : "Add to Cart",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (authState is Authenticated) {
                                  BlocProvider.of<AuthCubit>(context)
                                      .updateCart(
                                          selectedOption!.id!,
                                          authState.userdata.cart!
                                                  .contains(selectedOption!.id!)
                                              ? REMOVE
                                              : ADD)
                                      .then((value) {
                                    if (value == SUCCESS) {
                                      setState(() {
                                        //nothing
                                      });
                                    } else if (value == FAILED) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }
                                  });
                                }
                              },
                            )),
                            Expanded(
                                child: Container(
                              color: PRIMARY_SWATCH,
                              child: TextButton(
                                child: Text(
                                  "Buy Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                              create: (_) =>
                                                  CartFragmentCubit(),
                                              child: CartFragment(
                                                  selectedOption!.id))));
                                },
                              ),
                            )),
                          ]
                        : [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                    child: Text(
                                  "Out Of Stock",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ],
                  ),
                )
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
