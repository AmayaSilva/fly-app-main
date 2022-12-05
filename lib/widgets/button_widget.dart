import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget? child;
  final Color? buttonColor;
  final EdgeInsets padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  const ButtonWidget({
    Key? key,
    this.child = const Text('Click'),
    this.buttonColor,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 10.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
        child: Container(
          padding: padding,
          width: double.infinity,
          decoration: BoxDecoration(
            color: buttonColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius!),
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
