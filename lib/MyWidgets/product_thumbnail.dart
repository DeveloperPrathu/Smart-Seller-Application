import 'package:application/constants.dart';
import 'package:application/models/page_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductThumbnail extends StatelessWidget {
  ProductOptions product;
  double? width;

  ProductThumbnail(this.product, this.width);

  @override
  Widget build(BuildContext context) {
    
    if(width == null){
      width = (MediaQuery.of(context).size.width/2)-50;
    }
    return Container(
      margin: EdgeInsets.all(8),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: DOMAIN_URL + product.image!,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => Icon(Icons.warning),
            ),
          ),
          Text(product.title!, style: TextStyle(fontSize: 14, height: 1.4),
          maxLines: 2, overflow: TextOverflow.ellipsis,),
          Text(product.offerPrice!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          if(product.price != product.offerPrice)
          Text(product.price!.toString(), style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
