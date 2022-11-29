import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/emptypagesearch.dart';
import 'package:fitverse/components/loading_cards.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/model/contents.dart';
import 'package:fitverse/model/reservation.dart';
import 'package:fitverse/screen/articleDetail.dart';
import 'package:fitverse/screen/articlebasebooking.dart';
import 'package:fitverse/screen/categorybasecontent.dart';
import 'package:fitverse/tabandbloc/reservationbloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  BookmarkScreen({Key key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      controller = new ScrollController()..addListener(_scrollListener);
      // context.read<ReservationShowBloc>().getData(mounted);
      context.read<ReservationShowBloc>().onRefresh(mounted);
      Showwarningdialogbox(context);
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final db = context.read<ReservationShowBloc>();

    if (!db.isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        context.read<ReservationShowBloc>().setLoading(true);
        context.read<ReservationShowBloc>().getData(mounted);
      }
    }
  }

  void Showwarningdialogbox(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Please go to the place you booked before 5 minutes.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cb = context.watch<ReservationShowBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text('List of your reservation'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Feather.rotate_cw,
              size: 22,
            ),
            onPressed: () {
              context.read<ReservationShowBloc>().onRefresh(mounted);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        child: cb.hasData == false
            ? ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  EmptySearchPage(
                      icon: Feather.clipboard,
                      message: 'No data found',
                      message1: ''),
                ],
              )
            : ListView.separated(
                controller: controller,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                itemCount: cb.data.length != 0 ? cb.data.length + 1 : 10,
                itemBuilder: (_, int index) {
                  if (index < cb.data.length) {
                    return _ItemList(d: cb.data[index]);
                  }
                  return Opacity(
                    opacity: cb.isLoading ? 1.0 : 0.0,
                    child: cb.lastVisible == null
                        ? LoadingCard(height: null)
                        : Center(
                            child: SizedBox(
                                width: 32.0,
                                height: 32.0,
                                child: new CupertinoActivityIndicator()),
                          ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
        onRefresh: () async {
          context.read<ReservationShowBloc>().onRefresh(mounted);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ItemList extends StatelessWidget {
  final Reservation d;
  const _ItemList({Key key, this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ]),
        child: Wrap(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: 'reservation${d.timestamp}',
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: CustomCacheImage(
                          imageUrl: d.image,
                          // 'https://firebasestorage.googleapis.com/v0/b/myfitverse.appspot.com/o/bookingpic.jpg?alt=media&token=490557f2-846b-4a31-aa08-44f40d92ecb2',
                          radius: 5.0),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      HtmlUnescape()
                          .convert(parse(d.address).documentElement.text),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 12,
                          //color: Theme.of(context).secondaryHeaderColor
                          color: Colors.black)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Reservation date:",
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.rsdate,
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Reservation Time:",
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.starttiem,
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "to",
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        d.endtimef,
                        style: TextStyle(fontSize: 12, color: Colors.black
                            //color: Theme.of(context).secondaryHeaderColor
                            ),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        nextScreenAllApp(
            context,
            ArticleBookingDetail(
              data: d,
              tag: 'category${d.timestamp}',
            ));
      },
    );
  }
}
