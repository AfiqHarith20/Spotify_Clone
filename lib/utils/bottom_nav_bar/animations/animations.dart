import 'package:flutter/material.dart';

class OffsetAnimation extends StatefulWidget {
  final Widget? child;
  final bool? hideNavigationBar;
  final double? navBarHeight;
  final bool extendedLenght;
  final Function(bool, bool)? onAnimationComplete;
  const OffsetAnimation({
    Key? key,
    this.child,
    this.hideNavigationBar,
    this.navBarHeight,
    this.onAnimationComplete,
    this.extendedLenght = false,
  }) : super(key: key);

  @override
  State<OffsetAnimation> createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _navBarHideAnimationController;
  late Animation<Offset> _navBarOffsetAnimation;
  bool? _hideNavigationBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideNavigationBar = widget.hideNavigationBar;
    _navBarHideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _navBarOffsetAnimation = Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset(0, widget.navBarHeight! + 22.0))
        .chain(CurveTween(curve: Curves.ease))
        .animate(_navBarHideAnimationController);

    _hideAnimation();

    _navBarHideAnimationController.addListener(() {
      widget.onAnimationComplete!(_navBarHideAnimationController.isAnimating,
          _navBarHideAnimationController.isCompleted);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _navBarHideAnimationController.dispose();
    super.dispose();
  }

  _hideAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hideNavigationBar!) {
        _navBarHideAnimationController.forward();
      } else {
        _navBarHideAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hideNavigationBar != null ||
        _hideNavigationBar != widget.hideNavigationBar) {
      _hideNavigationBar = widget.hideNavigationBar;
      _hideAnimation();
    }
    return AnimatedBuilder(
      animation: _navBarOffsetAnimation,
      child: widget.child,
      builder: (context, child) => Transform.translate(
        offset: _navBarOffsetAnimation.value,
        child: child,
      ),
    );
  }
}
