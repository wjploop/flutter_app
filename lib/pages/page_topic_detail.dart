import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/topic.dart';
import 'package:flutter_app/data/topic_detail.dart';
import 'package:flutter_app/net/MyApi.dart';
import 'package:flutter_html/flutter_html.dart';

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
  List<ReplyItem> _replyList = [];

  @override
  void initState() {
    super.initState();
    // todo Scroller可以用使用全局的，这样可以实现全局左滑返回效果
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('try to loading more comment');
        if(_replyList.length > 0 && page <= maxPage) {
          _getData();
        }else{
          print('no more comment');
          HapticFeedback.heavyImpact();
        }
      }
    });
    _getData();
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  bool isLoading = false;
  int page = 1;
  int maxPage = 1;

  Future _getData({bool isRefresh= false} ) async {

    if (isLoading) {
      return;
    }

    isLoading = true;

    var topicDetail = await myApi.topicDetail(topic.url, page++);

    setState(() {
      _detailModel = topicDetail;
      if(isRefresh){
        _detailModel.replies.clear();
      }
      _replyList.addAll(_detailModel.replies);
      isLoading = false;
      // 加载第一页时，获取该详情的评论个数
      if(page == 2){
        maxPage =topicDetail.replySize;
        print('comments has $maxPage pages');
      }
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
        onRefresh: () => _getData(isRefresh: true),
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

  Widget detailCard(BuildContext context) {
    return Padding(
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
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: _detailModel == null
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                _detailModel.created,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                _detailModel.views,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(topic.title),
          ),
          _detailModel == null
              ? Container(
                  margin: EdgeInsets.all(16),
                  child: CircularProgressIndicator())
              : Html(
                  data: _detailModel.contentHtml,
                )
        ],
      ),
    );
  }

  Widget commentCard(BuildContext context) {
    return _detailModel == null
        ? Container()
        : _replyList.isEmpty
            ? Text("目前尚无回复")
            : ListView.builder(
                itemCount: _replyList.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => index == _replyList.length
                    ? Container(
                        margin: EdgeInsets.all(16),
                        child: Text("Loading page $page ..."),
                      )
                    : commentItem(context, index, _replyList[index]),
              );
  }

  Widget commentItem(BuildContext context, int index, ReplyItem item) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
                child: Image.network(
              item.avatar,
              width: 32,
              height: 32,
            )),
            SizedBox(width: 12,),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.username),
                            Text(
                              item.lastReplyTime,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {},
                          ))
                    ],
                  ),
                  Html(
                    data: item.contentHtml,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(" ${item.floor}楼"),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.more),
                          onPressed: () {},
                        ),
                      ),
                    ],
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
