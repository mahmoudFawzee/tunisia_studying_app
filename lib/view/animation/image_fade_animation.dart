import 'package:flutter/material.dart';

class MyFadeAnim extends StatefulWidget {
  const MyFadeAnim({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  State<MyFadeAnim> createState() => _MyFadeAnimState();
}

class _MyFadeAnimState extends State<MyFadeAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      _animationController,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return DoneImageAnimation(
      animation: _animation,
      child: widget.child,
    );
  }
}

class DoneImageAnimation extends AnimatedWidget {
  const DoneImageAnimation({
    Key? key,
    required Animation<double> animation,
    required this.child,
  }) : super(
          key: key,
          listenable: animation,
        );
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = super.listenable as Animation<double>;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
