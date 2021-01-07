import 'package:flutter/material.dart';
import 'package:flutter_app/data/topic.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;



  const TopicDetailPage({Key key, this.topic}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  Topic get topic => widget.topic;

  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("话题"),
      ),
      body: RefreshIndicator(
        onRefresh: () {},
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(topic.member.avatarMini,
                                width: 48, height: 48),
                            // Image.asset("avatar.png"),
                          ),
                          SizedBox(
                            width: 6,
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
                                    "点击",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(topic.title)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
