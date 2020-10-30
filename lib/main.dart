import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const scrollDelay = Duration(seconds: 1);
  static const posterAspectRatio = 680 / 1000;
  static const postersPerRow = 4;

  ScrollController _scrollController;
  VerticalDirection _scrollDirection = VerticalDirection.down;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final posters = [
      "https://artworks.thetvdb.com/banners/movies/140960/posters/5f737122aa435.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/311714/1227863-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/132143/posters/5f145b6d75da2.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/387115/62341664-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/141365/posters/5f7f58189f37b.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/361140/62354265-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/134511/posters/5ef215cc3a013.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/362412/62372258-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/140391/posters/5f8e2f1565c4f.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/73244/25861-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/141496/posters/5f8ef17783fec.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/386917/62340033-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/125840/posters/5f579be0a32f2.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/381838/62361854-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/3185/posters/3185.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/376921/62281336-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/132892/posters/5f6b4190cab33.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/355567/1337843-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/140519/posters/5f5a5e9cdf01b.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/360727/62292716-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/131678/posters/5f3c15dd60c0a.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/328690/62235860-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/140958/posters/5f7f516ef2bca.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/387055/62365112-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/141336/posters/5f85aacb2cc33.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/378074/62119542-0-optimized.jpg",
      "https://artworks.thetvdb.com/banners/movies/134115/posters/5e7961c37c983.jpg",
      "https://dg31sz3gwrwan.cloudfront.net/poster/372787/62011716-0-optimized.jpg",
    ];
    Future.delayed(scrollDelay).then((_) {
      _startBackgroundAnimation(_scrollDirection);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: NotificationListener(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            Future.delayed(scrollDelay).then((_) {
              _scrollDirection = _flipDirection(_scrollDirection);
              _startBackgroundAnimation(_scrollDirection);
            });
          }
          return true;
        },
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(0),
          itemCount: posters.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: posterAspectRatio,
            crossAxisCount: postersPerRow,
          ),
          itemBuilder: (context, index) {
            debugPrint("itemBuilder $index");
            final poster = posters.elementAt(index);
            return Image.network(
              poster,
              excludeFromSemantics: true,
              gaplessPlayback: true,
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.none,
              isAntiAlias: false,
            );
          },
        ),
      ),
    );
  }

  VerticalDirection _flipDirection(VerticalDirection direction) {
    switch (direction) {
      case VerticalDirection.down:
        return VerticalDirection.up;
      case VerticalDirection.up:
        return VerticalDirection.down;
    }
  }

  double _computeScrollOffset(VerticalDirection direction) {
    switch (direction) {
      case VerticalDirection.down:
        final posterWidth = MediaQuery.of(context).size.width / postersPerRow;
        final posterHeight = posterWidth / posterAspectRatio;
        return posterHeight;
      case VerticalDirection.up:
        return 0.0;
    }
  }

  void _startBackgroundAnimation(VerticalDirection direction) {
    debugPrint('_startBackgroundAnimation');
    final offset = _computeScrollOffset(direction);
    _scrollController.animateTo(
      offset,
      duration: Duration(seconds: 10),
      curve: Curves.linear,
    );
  }
}
