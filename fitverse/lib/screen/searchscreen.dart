import 'package:fitverse/card/cardsearch.dart';
import 'package:fitverse/components/barsearch.dart';
import 'package:fitverse/components/emptypagesearch.dart';
import 'package:fitverse/components/loading_cards.dart';
import 'package:fitverse/tabandbloc/searchbloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SearchScreenPage extends StatefulWidget {
  SearchScreenPage({Key key}) : super(key: key);

  _SearchScreenPageState createState() => _SearchScreenPageState();
}

class _SearchScreenPageState extends State<SearchScreenPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0))
        .then((value) => context.read<SearchAllWellness>().saerchInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchPageAppBar(),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, bottom: 5, right: 15),
              child: Text(
                context.watch<SearchAllWellness>().searchStarted == false
                    ? 'Your recent searchs'
                    : 'Your result',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            context.watch<SearchAllWellness>().searchStarted == false
                ? CounselUIpage()
                : SearchUIpage()
          ],
        ),
      ),
    );
  }

  Widget _searchPageAppBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: TextFormField(
        autofocus: true,
        controller: context.watch<SearchAllWellness>().textfieldCtrl,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search wellness centers",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).secondaryHeaderColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              context.read<SearchAllWellness>().saerchInitialize();
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if (value == '') {
            openBarSearch(scaffoldKey, 'Type your search!!');
          } else {
            context.read<SearchAllWellness>().setSearchText(value);
            context.read<SearchAllWellness>().addToSearchList(value);
          }
        },
      ),
    );
  }
}

class SearchUIpage extends StatelessWidget {
  const SearchUIpage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: context.watch<SearchAllWellness>().getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0)
              return EmptySearchPage(
                icon: Feather.clipboard,
                message: 'No Data Found',
                message1: "Please try again!!",
              );
            else
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CardSearchPage(
                      d: snapshot.data[index], heroTag: 'search$index');
                },
              );
          }
          return ListView.separated(
            padding: EdgeInsets.all(15),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              return LoadingCard(height: 120);
            },
          );
        },
      ),
    );
  }
}

class CounselUIpage extends StatelessWidget {
  const CounselUIpage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchAllWellness>();
    return Expanded(
      child: sb.recentSearchData.isEmpty
          ? EmptySearchPage(
              icon: Feather.search,
              message: 'Search wellness centers',
              message1: "You have not searched for any information.",
            )
          : ListView.separated(
              padding: EdgeInsets.all(15),
              itemCount: sb.recentSearchData.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: ListTile(
                    title: Text(
                      sb.recentSearchData[index],
                      style: TextStyle(fontSize: 17),
                    ),
                    leading: Icon(
                      CupertinoIcons.time_solid,
                      color: Colors.black,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.black,
                      onPressed: () {
                        context
                            .read<SearchAllWellness>()
                            .removeFromSearchList(sb.recentSearchData[index]);
                      },
                    ),
                    onTap: () {
                      context
                          .read<SearchAllWellness>()
                          .setSearchText(sb.recentSearchData[index]);
                    },
                  ),
                );
              },
            ),
    );
  }
}
