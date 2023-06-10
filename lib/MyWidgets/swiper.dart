import 'package:application/MyWidgets/product_thumbnail.dart';
import 'package:application/models/page_item_model.dart';
import 'package:flutter/material.dart';

class Swiper extends StatelessWidget {
  late Results result;

  Swiper(this.result);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text(result.title!, style: TextStyle(fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(onPressed: () {}, child: Text("View all")),

            ],
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: result.productOptions!.length,
                itemBuilder: (context, index){
                ProductOptions product = result.productOptions![index];
                return ProductThumbnail(product, 150);
            }),
          )
        ],
      ),
    );
  }
}
