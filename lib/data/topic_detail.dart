class TopicDetail {
  String topicId = "";
  String userId;
  // header
  String created="";
  String views ="";

  bool hasContent = false;
  // heaer
  String content = '';
  String contentHtml;

  List<Supplement> supplements = [];
  // reply


  // reply
  int replySize = 0;
  List<ReplyItem> replies = [];

}

class Supplement{
  String created;
  String content;
  String contentHtml;
}

class ReplyItem{
  String avatar ='';
  String username ='';
  String lastReplyTime = '';
  String contentHtml = ''; // 带html标签
  String content = '';
  String replyId = '';
  String favorites = '';
  String floor = ''; // 楼层
}

