import 'package:dns_changer/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  const IconWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.size = 32.0,
    this.isSelected = false,
  });
  final String icon;
  final bool isSelected;
  final Color? color;
  final double size;
  final VoidCallback onTap;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hover) {
        setState(() {
          _hover = hover;
        });
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
            color: widget.isSelected || _hover
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          widget.icon,
          color: widget.isSelected || _hover
              ? Theme.of(context).textTheme.bodySmall?.color
              : widget.color ?? AppColors.secondary,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
