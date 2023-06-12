import 'package:application/constants.dart';
import 'package:application/utils.dart';
import 'package:flutter/material.dart';

class ProductDetailsRatingView extends StatelessWidget {
  late String rating;
  int star5, star4, star3, star2, star1;
  var total;


  ProductDetailsRatingView(this.star5, this.star4, this.star3, this.star2, this.star1){
    rating = average(star5, star4, star3, star2, star1);
    total = star1 + star2 + star3 + star4 + star5;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ratings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        SizedBox(height: 16,),
        Row(
          children: [
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(rating, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Icon(Icons.star, size: 34, color: Colors.amber,)
              ],
            )),
            Expanded(child: Column(
              children: [
                _ratingProgress("5", total > 0? star5/total:0.0, Colors.green, star5),
                _ratingProgress("4", total > 0? star4/total:0.0, Colors.greenAccent, star4),
                _ratingProgress("3", total > 0? star3/total:0.0, Colors.lightGreen, star3),
                _ratingProgress("2", total > 0? star2/total:0.0, Colors.yellow, star2),
                _ratingProgress("1", total > 0? star1/total:0.0, Colors.red, star1),
                Divider(),
                Text('Total Ratings: $total')
              ],
            ))
          ],
        )
      ],
    );
  }
  
  _ratingProgress(title, progress, color, count){
    return Row(
      children: [
      Text(title + ' ', style: TextStyle(fontSize: 12, height: 1.8),)  ,
        Icon(Icons.star, size: 12,),
        SizedBox(height: 8,),
        Expanded(child: LinearProgressIndicator(value: progress, valueColor: AlwaysStoppedAnimation<Color>(color),)),
        SizedBox(height: 8,),
        Text(count.toString(), style: TextStyle(fontSize: 12, height: 1.8),)  ,
      ],
    );
  }
}
