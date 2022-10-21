import 'package:flutter/material.dart';

class AnimatedBar extends StatefulWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(

          builder: (context, constraints) {
            return Stack(
              children: <Widget>[

                _buildContainer(
                  double.infinity,
                  widget.position < widget.currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                widget.position == widget.currentIndex
                    ? AnimatedBuilder(
                  animation: widget.animController,

                  builder: (context, child) {
                    return _buildContainer(

                      constraints.maxWidth * widget.animController.value,
                      Colors.white,
                    );
                  },
                )
                    : const SizedBox.shrink(),



              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }


}