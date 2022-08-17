import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    this.borderColor = Colors.transparent,
    this.borderRadius = 20,
    this.buttonSize = 70,
    this.fillColor = const Color(0XFF04C774),
    required this.icon,
    required this.onPressed,
    this.isTaped = false,
  }) : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final Color borderColor;
  final IconData icon;
  final void Function() onPressed;
  final bool isTaped;

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
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  widget.icon,
                  size: 50,
                  color: hover || widget.isTaped
                      ? const Color(0XFFFFFFFF)
                      : const Color(0XFFB6B6B6),
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
