import 'package:flutter/material.dart';

class NaverWebtoonImage extends StatelessWidget {
  const NaverWebtoonImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      headers: const {
        // 이 값이 없으면 네이버에서 차단하고 403에러 발생
        'Referer': 'https://comic.naver.com',
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      },
    );
  }
}
