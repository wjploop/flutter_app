import 'package:flutter_app/data/member.dart';
import 'package:flutter_app/data/node.dart';

/// node : {"avatar_large":"https://cdn.v2ex.com/navatar/9f61/408e/56_large.png?m=1606912716","name":"internet","avatar_normal":"https://cdn.v2ex.com/navatar/9f61/408e/56_normal.png?m=1606912716","title":"互联网","url":"https://www.v2ex.com/go/internet","topics":2760,"footer":"","header":"In Internet we trust","title_alternative":"Internet","avatar_mini":"https://cdn.v2ex.com/navatar/9f61/408e/56_mini.png?m=1606912716","stars":832,"aliases":[],"root":false,"id":56,"parent_node_name":"computer"}
/// member : {"username":"guanyin8cnq12","website":null,"github":null,"psn":null,"avatar_normal":"https://cdn.v2ex.com/gravatar/62c96a4c872cce135b3ea2284c935312?s=24&d=retro","bio":null,"url":"https://www.v2ex.com/u/guanyin8cnq12","tagline":null,"twitter":null,"created":1604848323,"avatar_large":"https://cdn.v2ex.com/gravatar/62c96a4c872cce135b3ea2284c935312?s=24&d=retro","avatar_mini":"https://cdn.v2ex.com/gravatar/62c96a4c872cce135b3ea2284c935312?s=24&d=retro","location":null,"btc":null,"id":516537}
/// last_reply_by : "fox0001"
/// last_touched : 1608043387
/// title : "vultr 是不是挂了？"
/// url : "https://www.v2ex.com/t/735799"
/// created : 1608038675
/// content : "This site can’t provide a secure connection my.vultr.com uses an unsupported protocol.\r\nERR_SSL_VERSION_OR_CIPHER_MISMATCH\r\nUnsupported protocol\r\nThe client and server don't support a common SSL protocol version or cipher suite.\r\n提示这个"
/// content_rendered : "<p>This site can’t provide a secure connection <a href=\"http://my.vultr.com\" rel=\"nofollow\">my.vultr.com</a> uses an unsupported protocol.\nERR_SSL_VERSION_OR_CIPHER_MISMATCH\nUnsupported protocol\nThe client and server don't support a common SSL protocol version or cipher suite.\n提示这个</p>\n"
/// last_modified : 1608042548
/// replies : 4
/// id : 735799

class Topic {
  TopicNode node;
  Member member;
  String lastReplyBy;
  int lastTouched;
  String title;
  String url;
  int created;
  String content;
  String contentRendered;
  int lastModified;
  String lastTime;  // 可视化字符
  int replies;
  int id;

  Topic(
      {this.node,
      this.member,
      this.lastReplyBy,
      this.lastTouched,
      this.title,
      this.url,
      this.created,
      this.content,
      this.contentRendered,
      this.lastModified,
      this.lastTime,
      this.replies,
      this.id});

  Topic.fromJson(dynamic json) {
    node = json["node"] != null ? TopicNode.fromJson(json["node"]) : null;
    member = json["member"] != null ? Member.fromJson(json["member"]) : null;
    lastReplyBy = json["last_reply_by"];
    lastTouched = json["last_touched"];
    title = json["title"];
    url = json["url"];
    created = json["created"];
    content = json["content"];
    contentRendered = json["content_rendered"];
    lastModified = json["last_modified"];
    lastTime = json["last_time"];
    replies = json["replies"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (node != null) {
      map["node"] = node.toJson();
    }
    if (member != null) {
      map["member"] = member.toJson();
    }
    map["last_reply_by"] = lastReplyBy;
    map["last_touched"] = lastTouched;
    map["title"] = title;
    map["url"] = url;
    map["created"] = created;
    map["content"] = content;
    map["content_rendered"] = contentRendered;
    map["last_modified"] = lastModified;
    map["last_time"] = lastTime;
    map["replies"] = replies;
    map["id"] = id;
    return map;
  }
}
