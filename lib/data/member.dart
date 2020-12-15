/// username : "antalwang"
/// website : ""
/// github : ""
/// psn : ""
/// avatar_normal : "https://cdn.v2ex.com/gravatar/29aa4c1214795f54522050c4d8cc7704?s=24&d=retro"
/// bio : ""
/// url : "https://www.v2ex.com/u/antalwang"
/// tagline : ""
/// twitter : ""
/// created : 1536763727
/// avatar_large : "https://cdn.v2ex.com/gravatar/29aa4c1214795f54522050c4d8cc7704?s=24&d=retro"
/// avatar_mini : "https://cdn.v2ex.com/gravatar/29aa4c1214795f54522050c4d8cc7704?s=24&d=retro"
/// location : ""
/// btc : ""
/// id : 349141

class Member {
  String username;
  String website;
  String github;
  String psn;
  String avatarNormal;
  String bio;
  String url;
  String tagline;
  String twitter;
  int created;
  String avatarLarge;
  String avatarMini;
  String location;
  String btc;
  int id;

  Member({
      this.username, 
      this.website, 
      this.github, 
      this.psn, 
      this.avatarNormal, 
      this.bio, 
      this.url, 
      this.tagline, 
      this.twitter, 
      this.created, 
      this.avatarLarge, 
      this.avatarMini, 
      this.location, 
      this.btc, 
      this.id});

  Member.fromJson(dynamic json) {
    username = json["username"];
    website = json["website"];
    github = json["github"];
    psn = json["psn"];
    avatarNormal = json["avatar_normal"];
    bio = json["bio"];
    url = json["url"];
    tagline = json["tagline"];
    twitter = json["twitter"];
    created = json["created"];
    avatarLarge = json["avatar_large"];
    avatarMini = json["avatar_mini"];
    location = json["location"];
    btc = json["btc"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["username"] = username;
    map["website"] = website;
    map["github"] = github;
    map["psn"] = psn;
    map["avatar_normal"] = avatarNormal;
    map["bio"] = bio;
    map["url"] = url;
    map["tagline"] = tagline;
    map["twitter"] = twitter;
    map["created"] = created;
    map["avatar_large"] = avatarLarge;
    map["avatar_mini"] = avatarMini;
    map["location"] = location;
    map["btc"] = btc;
    map["id"] = id;
    return map;
  }

}