import 'package:flutter/material.dart';

class SwipeCardScreen extends StatefulWidget {
  const SwipeCardScreen({super.key});

  @override
  State<SwipeCardScreen> createState() {
    return _SwipeCardScreenState();
  }
}

class _SwipeCardScreenState extends State<SwipeCardScreen> {
  String _action = 'Swipe the card!';
  Color _color = Colors.blue;

  void _skipCard() {
    setState(() {
      _action = 'Skipped';
      _color = Colors.red;
    });
  }

  void _likeCard() {
    setState(() {
      _action = 'Liked';
      _color = Colors.green;
    });
  }

  void _superLikeCard() {
    setState(() {
      _action = 'Super Liked';
      _color = Colors.amber;
    });
  }

  void _handleHorizontalSwipe(DragEndDetails details) {
    double swipeVelocity = details.primaryVelocity ?? 0;

    if (swipeVelocity < 0) {
      _skipCard();
    } else if (swipeVelocity > 0) {
      _likeCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Gesture Card')),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onHorizontalDragEnd: _handleHorizontalSwipe,
            onDoubleTap: _superLikeCard,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _action,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
