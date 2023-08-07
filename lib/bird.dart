import 'dart:ui';

import 'package:flappy_bird_game/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Image.asset(AssetsConstants.bird),
    );
  }
}
