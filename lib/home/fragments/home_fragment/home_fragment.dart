import 'package:application/MyWidgets/category_item.dart';
import 'package:application/MyWidgets/slider_carousel.dart';
import 'package:application/constants.dart';
import 'package:application/home/fragments/home_fragment/home_fragment_cubit.dart';
import 'package:application/home/fragments/home_fragment/home_fragment_state.dart';
import 'package:application/models/slide_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeFragmentCubit, HomeFragmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeFragmentInitial) {
            BlocProvider.of<HomeFragmentCubit>(context).loadCategories();
          }
          if (state is HomeFragmentLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  toolbarHeight: 150,
                  titleSpacing: 0,
                  backgroundColor: Colors.white,
                  title: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: PRIMARY_SWATCH,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0)
                          ),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [Icon(Icons.search, color: Colors.grey,), Text('Search', style: TextStyle(color: Colors.grey),)],
                              ),
                            )),
                      ),
                      SizedBox(height: 12,),
                      SizedBox(height: 80, child: _categories(state),)
                    ],
                  ),
                ),
                SliverList(delegate: SliverChildBuilderDelegate((context, index){
                  return listItem(state, 0);
                }, childCount: 1),
                )
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  _categories(state) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (_, index) {
          return CategoryItem(state.categories[index]);
        });
  }

  listItem(state, viewtype){
    switch(viewtype){
      case 0:
        return SliderCarousel(List.from(state.slides.map((SlideModel slide)=>slide.image.toString())));
      default:
        return Text('error');
    }
  }
}
