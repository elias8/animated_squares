import 'package:flutter/material.dart';

class AnimatedSquare extends StatefulWidget {
  final int index;
  final int rows;

  const AnimatedSquare({Key key, this.index, this.rows})
      : assert(index != null),
        assert(rows != null),
        super(key: key);

  @override
  _AnimatedSquareState createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare>
    with SingleTickerProviderStateMixin {
  static const minBoxHeight = 20;
  static const maxBoxHeight = 60;

  AnimationController _controller;
  Animation<double> _heightAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxHeight - maxBoxHeight) / maxBoxHeight;
        return AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < columns; i++)
                  Container(
                    width: 20,
                    height: minBoxHeight +
                        (maxBoxHeight - minBoxHeight) * _heightAnimation.value,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedSquare oldWidget) {
    if (oldWidget.rows != widget.rows) {
      _playAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final duration = Duration(milliseconds: 3000);
    _controller = AnimationController(vsync: this, duration: duration)
      ..addStatusListener(_statusListener);
    _heightAnimation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
    _playAnimation();
  }

  void _playAnimation() {
    final halfRow = widget.rows ~/ 2;
    final delayMilli = 3000 ~/ halfRow;
    Duration delay = Duration(milliseconds: delayMilli * widget.index);
    if (widget.index > halfRow) {
      // print(halfRow - (halfRow - widget.index));
      print(widget.index - halfRow);
      delay = Duration(milliseconds: delayMilli * widget.index - halfRow);
    }

    Future.delayed(delay, () => _controller.forward(from: 0));
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }
}
