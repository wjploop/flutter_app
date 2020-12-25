import 'package:flutter/material.dart';
import 'package:flutter_app/base/page.dart';
import 'package:flutter_app/data/topic.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/home.dart';

class TopicListPage extends StatefulWidget {
  final String tab;

  const TopicListPage({Key key, this.tab}) : super(key: key);

  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  String tab="";
  final data = <Topic>[];
  @override
  Widget build(BuildContext context) {
    if(tab != tabList[context.watch<TabIndex>().index].href) {
      context.findAncestorStateOfType<_TopicListPageState>().
    }
    return ListPage(
      data,
      _getData,
      getItemBuilder(),
      enableLoadMore: false,
    );
  }

  Future<List<Topic>> _getData() {
    return myApi.topic(tab);
  }

  IndexedWidgetBuilder getItemBuilder() {
    return (BuildContext context, index) {
      var topic = data[index];
      var imgUrl = "${topic.member.avatarMini}";

      print(imgUrl);
      return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(imgUrl, width: 32, height: 32),
                          // Image.asset("avatar.png"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(topic.member.username),
                            Row(
                              children: [
                                Text(
                                  topic.lastTime,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "评论${topic.replies}",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    FlatButton(
                      visualDensity: VisualDensity(horizontal: -4,vertical: -2),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text(topic.node.title,
                          style: TextStyle(fontSize: 10)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 12),
                child: Text(
                  topic.title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 15,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    };
  }
}
