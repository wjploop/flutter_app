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


}

class Supplement{
  String created;
  String content;
  String contentHtml;
}

