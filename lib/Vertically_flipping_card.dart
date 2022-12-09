import 'package:flutter/material.dart';
import 'dart:math';

class VerticallyFlippingCard extends StatefulWidget {
  final Widget frontCard;
  final Widget backCard;
  final Duration duration;
  const VerticallyFlippingCard(
      {Key? key, required this.frontCard, required this.backCard, required this.duration})
      : super(key: key);

  @override
  _VerticallyFlippingCardState createState() => _VerticallyFlippingCardState();
}

class _VerticallyFlippingCardState extends State<VerticallyFlippingCard> {
  //declare the isBack bool
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: angle),
          duration:widget.duration,
          builder: (BuildContext context, double val, __) {
            //here we will change the isBack val so we can change the content of the card
            if (val >= (pi / 2)) {
              isBack = false;
            } else {
              isBack = true;
            }
            return (Transform(
                //let's make the card flip by it's center
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(val),
                child: isBack
                    ? widget.frontCard //if it's back we will display here
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateX(pi),
                        child: widget.backCard) //else we will display it here,

                ));
          }),
    );
  }
}
