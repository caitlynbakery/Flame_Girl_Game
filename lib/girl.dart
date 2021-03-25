import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'dart:ui' as ui;

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