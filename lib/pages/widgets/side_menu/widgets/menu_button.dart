import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    this.borderRadius = 20,
    this.buttonSize = 70,
    this.fillColor = const Color(0XFF09A963),
    required this.icon,
    this.iconColor = const Color(0XFFB6B6B6),
    required this.onPressed,
    this.isTaped = false,
    required this.tooltip,
  }) : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final IconData icon;
  final Color iconColor;
  final void Function() onPressed;
  final bool isTaped;
  final String tooltip;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Material(
        borderRadius: hover ? BorderRadius.circular(widget.borderRadius) : null,
        elevation: hover ? 5 : 0,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: SizedBox(
            width: widget.buttonSize,
            height: widget.buttonSize,
            child: Container(
              decoration: BoxDecoration(
                border: hover || widget.isTaped
                    ? Border.all(color: const Color(0XFFFFFFFF), width: 2)
                    : null,
                borderRadius: BorderRadius.circular(20),
                color: hover || widget.isTaped ? widget.fillColor : null,
              ),
              child: Tooltip(
                message: widget.tooltip,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    widget.icon,
                    size: 50,
                    color: hover || widget.isTaped
                        ? const Color(0XFFFFFFFF)
                        : widget.iconColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onHover: (_) {
        hover = true;
        setState(() {});
      },
      onExit: (_) {
        hover = false;
        setState(() {});
      },
    );
  }
}
