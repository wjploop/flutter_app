import 'package:flutter/material.dart';
import 'package:flutter_app/data/topic.dart';
import 'package:flutter_app/data/topic_detail.dart';
import 'package:flutter_app/net/MyApi.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;

  const TopicDetailPage({Key key, this.topic}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  Topic get topic => widget.topic;

  ScrollController _scrollController;

  TopicDetail _detailModel;

  @override
  void initState() {
    super.initState();
    _scrollController = PrimaryScrollController.of(context);

    _getData();
  }

  bool isLoading = false;
  int page = 1;
  int maxPage = 1;

  Future _getData() async {
    if (isLoading) {
      return;
    }

    isLoading = true;

    var topicDetail = await myApi.topicDetail(topic.url, page++);

    setState(() {
      _detailModel = topicDetail;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              detailCard(context),
              commentCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Card detailCard(BuildContext context) {
    return Card(
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
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "点击",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(topic.title),
            _detailModel == null
                ? CircularProgressIndicator()
                : Container(
                    child: Text("content"),
                  )
          ],
        ),
      ),
    );
  }

  Card commentCard(BuildContext context) {
    return Card();
  }
}
