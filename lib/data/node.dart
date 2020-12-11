/// avatar_large : "https://cdn.v2ex.com/navatar/c4ca/4238/1_large.png?m=1494924246"
/// name : "babel"
/// avatar_normal : "https://cdn.v2ex.com/navatar/c4ca/4238/1_normal.png?m=1494924246"
/// title : "Project Babel"
/// url : "https://www.v2ex.com/go/babel"
/// topics : 1122
/// footer : "V2EX 基于 Project Babel 驱动。Project Babel 是用 Python 语言写成的，运行于 Google App Engine 云计算平台上的社区软件。Project Babel 当前开发分支 2.5。最新版本可以从 <a href=\"http://github.com/livid/v2ex\" target=\"_blank\">GitHub</a> 获取。"
/// header : "Project Babel - 帮助你在云平台上搭建自己的社区"
/// title_alternative : "Project Babel"
/// avatar_mini : "https://cdn.v2ex.com/navatar/c4ca/4238/1_mini.png?m=1494924246"
/// stars : 399
/// aliases : []
/// root : false
/// id : 1
/// parent_node_name : "v2ex"

class Node {
  String avatarLarge;
  String name;
  String avatarNormal;
  String title;
  String url;
  int topics;
  String footer;
  String header;
  String titleAlternative;
  String avatarMini;
  int stars;
  bool root;
  int id;
  String parentNodeName;

  Node(
      {this.avatarLarge,
      this.name,
      this.avatarNormal,
      this.title,
      this.url,
      this.topics,
      this.footer,
      this.header,
      this.titleAlternative,
      this.avatarMini,
      this.stars,
      this.root,
      this.id,
      this.parentNodeName});

  Node.fromJson(dynamic json) {
    avatarLarge = json["avatar_large"];
    name = json["name"];
    avatarNormal = json["avatar_normal"];
    title = json["title"];
    url = json["url"];
    topics = json["topics"];
    footer = json["footer"];
    header = json["header"];
    titleAlternative = json["title_alternative"];
    avatarMini = json["avatar_mini"];
    stars = json["stars"];
    root = json["root"];
    id = json["id"];
    parentNodeName = json["parent_node_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["avatar_large"] = avatarLarge;
    map["name"] = name;
    map["avatar_normal"] = avatarNormal;
    map["title"] = title;
    map["url"] = url;
    map["topics"] = topics;
    map["footer"] = footer;
    map["header"] = header;
    map["title_alternative"] = titleAlternative;
    map["avatar_mini"] = avatarMini;
    map["stars"] = stars;
    map["root"] = root;
    map["id"] = id;
    map["parent_node_name"] = parentNodeName;
    return map;
  }

  @override
  String toString() {
    return 'Node{avatarLarge: $avatarLarge, name: $name, avatarNormal: $avatarNormal, title: $title, url: $url, topics: $topics, footer: $footer, header: $header, titleAlternative: $titleAlternative, avatarMini: $avatarMini, stars: $stars, root: $root, id: $id, parentNodeName: $parentNodeName}';
  }
}
