import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv/tv.dart';

import '../../core.dart';
import '../../utils/routes.dart';
import '../provider/home_notifier.dart';
import 'watchlist_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _drawerAnimationController;
  late Animation _drawerTween;

  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _drawerTween = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOutCirc,
      ),
    );

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
    );
    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withOpacity(0.7),
    ).animate(_colorAnimationController);
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  void toggle() {
    if (_drawerAnimationController.isDismissed) {
      _drawerAnimationController.forward();
    } else {
      _drawerAnimationController.reverse();
    }
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSpaceGrey,
      child: AnimatedBuilder(
        animation: _drawerTween,
        builder: (context, child) {
          double slide = 250.0 * _drawerTween.value;
          double scale = 1.0 - (_drawerTween.value * 0.15);
          double radius = _drawerTween.value * 30.0;
          double toolbarOpacity = 1.0 - _drawerTween.value;

          return Stack(
            children: [
              SizedBox(
                width: 220.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        key: const Key('closeDrawerButton'),
                        onTap: toggle,
                        child: const CircleAvatar(
                          child: Icon(Icons.close, color: kRichBlack),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 128.0),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: const Image(
                                image: AssetImage('assets/user.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Consumer<HomeNotifier>(builder: (context, data, child) {
                        return Column(
                          children: [
                            ListTile(
                              key: const Key('movieListTile'),
                              onTap: () {
                                Provider.of<HomeNotifier>(context, listen: false)
                                .setState(GeneralContentType.movie);
                                toggle();
                              },
                              leading: const Icon(Icons.movie),
                              title: const Text('Movies'),
                              selected: data.state == GeneralContentType.movie,
                              style: ListTileStyle.drawer,
                              iconColor: Colors.white70,
                              textColor: Colors.white70,
                              selectedColor: Colors.white,
                              selectedTileColor: kIndigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            ListTile(
                              key: const Key('tvListTile'),
                              onTap: () {
                                Provider.of<HomeNotifier>(context, listen: false)
                                .setState(GeneralContentType.tv);
                                toggle();
                              },
                              leading: const Icon(Icons.tv),
                              title: const Text('TV Show'),
                              selected: data.state == GeneralContentType.tv,
                              style: ListTileStyle.drawer,
                              iconColor: Colors.white70,
                              textColor: Colors.white70,
                              selectedColor: Colors.white,
                              selectedTileColor: kIndigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        );
                      }),
                      ListTile(
                        key: const Key('watchlistListTile'),
                        onTap: () {
                          Navigator.pushNamed(context, WatchlistPage.routeName);
                        },
                        leading: const Icon(Icons.save_alt),
                        title: const Text('Watchlist'),
                        iconColor: Colors.white70,
                        textColor: Colors.white70,
                      ),
                      ListTile(
                        key: const Key('aboutListTile'),
                        onTap: () {
                          Navigator.pushNamed(context, aboutRoute);
                        },
                        leading: const Icon(Icons.info_outline),
                        title: const Text('About'),
                        iconColor: Colors.white70,
                        textColor: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: AnimatedBuilder(
                    animation: _colorAnimationController,
                    builder: (context, child) {
                      return Scaffold(
                        extendBodyBehindAppBar: true,
                        appBar: AppBar(
                          toolbarOpacity: toolbarOpacity,
                          backgroundColor: _colorTween.value,
                          elevation: 0.0,
                          leading: IconButton(
                            key: const Key('drawerButton'),
                            icon: const Icon(Icons.menu),
                            splashRadius: 20.0,
                            onPressed: toggle,
                          ),
                          title: const Text(
                            'MDB',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          actions: [
                            Consumer<HomeNotifier>(
                              builder: (context, data, child) {
                                final state = data.state;
                                return IconButton(
                                  key: const Key('searchButton'),
                                  icon: const Icon(Icons.search),
                                  splashRadius: 20.0,
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    state == GeneralContentType.movie
                                    ? movieSearchRoute
                                    : tvSearchRoute,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        body: NotificationListener<ScrollNotification>(
                          onNotification: _scrollListener,
                          child: Consumer<HomeNotifier>(
                            builder: (context, data, child) {
                              final state = data.state;
                              if (state == GeneralContentType.movie) {
                                return const MainMoviePage();
                              } else {
                                return const MainTvPage();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
