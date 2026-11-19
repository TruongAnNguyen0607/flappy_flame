import 'package:flame/game.dart';

import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'core/game.dart';
import 'start_menu.dart';

class SplashScreenGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/game': (context) => GameWidget<FlappyGame>(
          game: FlappyGame(),
          overlayBuilderMap: {
            FlappyGame.startMenuOverlay: (context, game) =>
                StartMenu(game: game),
          },
        ),
      },
      home: FlameSplashScreen(
        theme: FlameSplashTheme.white,
        onFinish: (BuildContext context) =>
            Navigator.pushNamed(context, '/game'),
      ),
    );
  }
}
