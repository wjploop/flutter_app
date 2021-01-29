import 'package:flutter_app/data/topic.dart';

class NodeDetail {
  String nodeId = '';
  String nodeName = '';
  String nodeImage = '';
  String introduce = '';


  int topicSize = 0;
  int favoriteMemberSize = 0; // 多少人收藏了该节点
  bool isFavorite = false; // 是否收藏

  int pageSize = 1;

  List<Topic> topics = [];

}
