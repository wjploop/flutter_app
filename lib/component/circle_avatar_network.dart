import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarNetwork extends StatelessWidget {
  final String url;
  final double size;


  CircleAvatarNetwork(this.url, this.size,{Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Image.asset("assets/images/ic_person.png");
        },
      ),
    );
  }
}
