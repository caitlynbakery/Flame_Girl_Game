import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

void main() {
  runApp(GameWidget(game: MyApp()));
}

class MyApp extends BaseGame with DoubleTapDetector {
  SpriteComponent boy = SpriteComponent();
  SpriteAnimationComponent girlAnimation = SpriteAnimationComponent();
  String direction = 'right';
  bool running = true;
  Sprite starSprite;

  @override
  Future<void> onLoad() async {
    print('loading assets');


    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('background.png')
      ..size = size;

    add(background);
    print(size);

    starSprite = await loadSprite('Star.png');

    SpriteComponent star = SpriteComponent()
      ..sprite = starSprite
      ..size = Vector2(50, 50)
      ..x = 200
      ..y = 250;

    add(star);

    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(150.0, 150.0)
      ..x = size[0] - 200
      ..y = 200.0;

    add(boy);

    var spriteSheet = await images.load('spritesheet.png');
    final spriteSize = Vector2(150 * 0.7, 163 * 0.7);
    SpriteAnimationData spriteData = 
    SpriteAnimationData.sequenced(amount: 20, stepTime: 0.03, textureSize: Vector2(150, 163));

    girlAnimation = SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
      ..x = 100
      ..y = size[1] - 163
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
