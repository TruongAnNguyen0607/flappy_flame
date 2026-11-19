import 'dart:ui';
import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart' hide Timer;

import '../component/pipe.dart';

class PipeGenerator {
  late Image _topPipeImage;
  late Vector2 _topPipePosition;
  late Image _bottomPipeImage;
  late Vector2 _bottomPipePosition;
  late double _gapSize;
  late List<Pipe> _pipes;
  static const MIN_PIPE_HEIGHT = 100;

  PipeGenerator(
    Image topPipeImage,
    Image bottomPipeImage,
    Vector2 topPipePosition,
    Vector2 bottomPipePosition,
    double gapSize,
  ) {
    _topPipeImage = topPipeImage;
    _bottomPipeImage = bottomPipeImage;
    // create a new Vector2 to avoid position issues
    _topPipePosition = Vector2(topPipePosition.x, topPipePosition.y);
    // create a new Vector2 to avoid position issues
    _bottomPipePosition = Vector2(bottomPipePosition.x, bottomPipePosition.y);
    _gapSize = gapSize;
    _pipes = [];
  }

  void cleanUpPipes() {
    _pipes = [];
  }

  Stream<SpriteComponent> startPipeGeneration() {
    late StreamController<SpriteComponent> controller;
    Timer? timer;
    final interval = Duration(milliseconds: 2500);

    void tick(_) {
      final pipesHeight = _getPipesHeight();

      final topPipeSize = Vector2(64, pipesHeight.topPipeHeight);
      final bottomPipeSize = Vector2(64, pipesHeight.bottomPipeHeight);

      // create new Vector2 to avoid position issues
      final topPipePosition = Vector2(_topPipePosition.x, _topPipePosition.y);
      final bottomPipePosition = Vector2(
        _bottomPipePosition.x,
        (_bottomPipePosition.y - bottomPipeSize.y),
      );

      final topPipe = Pipe(_topPipeImage, topPipeSize, topPipePosition, true);
      final bottomPipe = Pipe(
        _bottomPipeImage,
        bottomPipeSize,
        bottomPipePosition,
        false,
      );

      _pipes.addAll([topPipe, bottomPipe]);

      controller.add(topPipe);
      controller.add(bottomPipe);
    }

    void stopTimer() {
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }

      controller.close();
    }

    void startTimer() {
      timer = Timer.periodic(interval, tick);
    }

    controller = StreamController<SpriteComponent>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer,
    );

    return controller.stream;
  }

  void updatePipes() {
    final newPipes = _pipes.map((pipe) {
      if (pipe.position.x + pipe.size.x > 0) {
        pipe.position.x -= 2;
        return pipe;
      }
    }).toList();

    // map set item to null if it's not return by callback
    // so we need to remove null item from _pipes
    _pipes = newPipes.whereType<Pipe>().toList();
  }

  PipesHeight _getPipesHeight() {
    final topPipeMaxHeight = _bottomPipePosition.y - MIN_PIPE_HEIGHT - _gapSize;
    final topPipeHeight = _getRandomPipeHeight(topPipeMaxHeight.toInt());

    final bottomPipeHeight = _bottomPipePosition.y - topPipeHeight - _gapSize;

    return PipesHeight(topPipeHeight, bottomPipeHeight);
  }

  double _getRandomPipeHeight(int max) {
    final _random = new Random();
    return MIN_PIPE_HEIGHT + _random.nextInt(max - MIN_PIPE_HEIGHT).toDouble();
  }

  List<Pipe> get getPipes => _pipes;
}

class PipesHeight {
  double topPipeHeight;
  double bottomPipeHeight;

  PipesHeight(this.topPipeHeight, this.bottomPipeHeight);
}
