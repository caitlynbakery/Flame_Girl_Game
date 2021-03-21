import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

void main() {
  runApp(GameWidget(game: MyApp()));
}

class MyApp extends BaseGame with DoubleTapDetector {
  SpriteComponent girl = SpriteComponent();
  SpriteAnimationComponent girlAnimation = SpriteAnimationComponent();
  String direction = 'right';
  bool running = true;

  @override
  Future<void> onLoad() async {
    print('loading assets');
    print(size);

    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(153, 160)
      ..x = 100.0
      ..y = 60.0;

    // add(girl);

    var spriteSheet = await images.load('spritesheet.png');
    final spriteSize = Vector2(150, 163);
    SpriteAnimationData spriteData = 
    SpriteAnimationData.sequenced(amount: 20, stepTime: 0.03, textureSize: Vector2(150, 163));

    girlAnimation = SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
      ..x = 100
      ..y = size[1] - 163/2
      ..anchor = Anchor.center
      ..size = spriteSize;

    add(girlAnimation);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    switch (direction){
      case 'right':
        girlAnimation.x += 1;
        break;
      case 'left':
        girlAnimation.x -= 1;
        break;
    }

    if (girlAnimation.x > size[0]) {
      direction = "left";
    }
    if (girlAnimation.x < 10) {
      direction = "right";
    }
  }

  @override 
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } if(!running){
      resumeEngine();
    }
    running = !running;
  }
}
