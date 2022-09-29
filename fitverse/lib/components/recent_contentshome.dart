import 'package:fitverse/card/card1.dart';
import 'package:fitverse/card/card2.dart';
import 'package:fitverse/card/card3.dart';
import 'package:fitverse/components/loading_indicator_widget.dart';
import 'package:fitverse/tabandbloc/recent_contentsbloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentContents extends StatefulWidget {
  RecentContents({Key key}) : super(key: key);

  @override
  _RecentContentsState createState() => _RecentContentsState();
}

class _RecentContentsState extends State<RecentContents> {
  @override
  Widget build(BuildContext context) {
    final rb = context.watch<RecentBloc>();

    return Column(
      children: <Widget>[
        Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 15, bottom: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 22,
                  width: 4,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  width: 6,
                ),
                Text('Recent wellness centers',
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -0.6,
                        wordSpacing: 1,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        ListView.separated(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          physics: NeverScrollableScrollPhysics(),
          itemCount: rb.data.length != 0 ? rb.data.length + 1 : 1,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 15,
          ),
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            if (index < rb.data.length) {
              if (index % 3 == 0 && index != 0)
                return Card1(d: rb.data[index], heroTag: 'recent$index');
              if (index % 5 == 0 && index != 0)
                return Card2(d: rb.data[index], heroTag: 'recent$index');
              else
                return Card3(
                  d: rb.data[index],
                  heroTag: 'recent$index',
                );
            }
            return Opacity(
              opacity: rb.isLoading ? 1.0 : 0.0,
              child: LoadingIndicatorWidget(),
            );
            // return Opacity(
            //   opacity: rb.isLoading ? 1.0 : 0.0,
            //   child: Center(
            //     child: SizedBox(
            //         width: 32.0,
            //         height: 32.0,
            //         child: new CupertinoActivityIndicator()),
            //   ),
            // );
          },
        )
      ],
    );
  }
}
