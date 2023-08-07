import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  final size;
  const Barriers({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(
          width: 10,
          color: Colors.brown,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
