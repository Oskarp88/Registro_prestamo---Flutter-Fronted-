import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key, 
    required this.title, 
    this.smallSize = false, 
    this.maxLines = 2, 
    this.textAling = TextAlign.center,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign textAling;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize ? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAling,
    );
  }
}

