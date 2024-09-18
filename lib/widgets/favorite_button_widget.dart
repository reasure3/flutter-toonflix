import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteButton extends StatefulWidget {
  final String webtoonId;

  const FavoriteButton({
    super.key,
    required this.webtoonId,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  static const String likedToonsKey = "likedToons";

  late SharedPreferences prefs;

  bool isLiked = false;

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList(likedToonsKey);
    if (likedToons != null) {
      if (likedToons.contains(widget.webtoonId)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList(likedToonsKey, []);
    }
  }

  void onHeartTap() async {
    final likedToons = prefs.getStringList(likedToonsKey);
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.webtoonId);
      } else {
        likedToons.add(widget.webtoonId);
      }
      likedToons.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      await prefs.setStringList(likedToonsKey, likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onHeartTap,
      icon: isLiked
          ? const Icon(Icons.favorite_rounded)
          : const Icon(Icons.favorite_border_rounded),
    );
  }
}
