import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'boy.dart';

void main() {
  runApp(GameWidget(game: MyApp()));
}

class MyApp extends BaseGame with DoubleTapDetector, HasCollidables {
  Boy boy = Boy();
  Girl girlAnimation = Girl();
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

    girlAnimation = Girl.fromFrameData(spriteSheet, spriteData)
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



class Girl extends SpriteAnimationComponent with Hitbox, Collidable {

   Girl({
    Vector2 position,
    Vector2 size,
  }) : super(position: position, size: size);

  /// Creates a SpriteAnimationComponent from a [size], an [image] and [data]. Check [SpriteAnimationData] for more info on the available options.
  ///
  /// Optionally [removeOnFinish] can be set to true to have this component be auto removed from the BaseGame when the animation is finished.
  Girl.fromFrameData(
    ui.Image image,
    SpriteAnimationData data, {
    Vector2 position,
    Vector2 size,
  }) : super(position: position, size: size) {
    animation = SpriteAnimation.fromFrameData(image, data);
    // debugMode = true;
    addShape(HitboxRectangle());
  }

}
