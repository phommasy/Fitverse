import 'package:dots_indicator/dots_indicator.dart';
import 'package:fitverse/card/featured_card.dart';
import 'package:fitverse/components/loading_cards.dart';
import 'package:fitverse/tabandbloc/featured_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Featured extends StatefulWidget {
  Featured({Key key}) : super(key: key);

  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    final fb = context.watch<FeaturedBloc>();
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 250,
          width: w,
          child: PageView.builder(
            controller: PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            itemCount: fb.data.isEmpty ? 1 : fb.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (fb.data.isEmpty) return LoadingFeaturedCard();
              return FeaturedCard(
                  d: fb.data[index], heroTag: 'ads_banners$index');
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: DotsIndicator(
            dotsCount: fb.data.isEmpty ? 5 : fb.data.length,
            position: listIndex.toDouble(),
            decorator: DotsDecorator(
              color: Colors.black26,
              activeColor: Colors.black,
              spacing: EdgeInsets.only(left: 6),
              size: const Size.square(5.0),
              activeSize: const Size(20.0, 4.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        )
      ],
    );
  }
}
