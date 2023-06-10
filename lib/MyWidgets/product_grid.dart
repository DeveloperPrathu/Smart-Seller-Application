import 'package:application/MyWidgets/product_thumbnail.dart';
import 'package:application/models/page_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  late Results result;

  ProductGrid(this.result);

  @override
  Widget build(BuildContext context) {
    int productsCount = result.productOptions!.length;
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(result.title!, style: TextStyle(fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(onPressed: () {}, child: Text("View all")),

            ],
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProductThumbnail(result.productOptions![0], null),
                if(productsCount>1)
                  ...[
                    VerticalDivider(thickness: 1, color: Colors.grey,),
                    ProductThumbnail(result.productOptions![1], null)
                  ]
              ],
            ),
          ),
          if(productsCount>2)
            ...[
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProductThumbnail(result.productOptions![2], null),
                    if(productsCount>3)
                      ...[
                        VerticalDivider(thickness: 1, color: Colors.grey,),
                        ProductThumbnail(result.productOptions![3], null)
                      ]
                  ],
                ),
              ),
            ]
        ],
      ),
    );
  }
}
