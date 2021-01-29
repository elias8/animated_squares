import 'package:flutter/material.dart';

import 'animated_square.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    title: 'Animated Squares',
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        final rows = (constraint.maxWidth - 20) ~/ 20;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < rows; i++) AnimatedSquare(index: i, rows: rows)
          ],
        );
      }),
    );
  }
}
