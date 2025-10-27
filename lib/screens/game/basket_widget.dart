import 'package:flutter/material.dart';

class BasketWidget extends StatelessWidget {
  final double basketPosition;
  final double basketWidthFactor;

  const BasketWidget({
    super.key,
    required this.basketPosition,
    required this.basketWidthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left:
          (basketPosition - basketWidthFactor / 2) *
          MediaQuery.of(context).size.width,
      child: Container(
        width: MediaQuery.of(context).size.width * basketWidthFactor,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.brown.shade800,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.shade400, width: 3),
        ),
        child: Center(
          child: Text('Basket', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
