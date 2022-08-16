import 'package:arux/helpers/globalUtility.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({Key? key, required this.icono, required this.color})
      : super(key: key);

  final IconData icono;
  final Color color;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool hover = false;

  GlobalUtility globalUtility = GlobalUtility();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Material(
        borderRadius: hover ? BorderRadius.circular(20) : null,
        color: globalUtility.transparente,
        elevation: hover ? 5 : 0,
        child: SizedBox(
          height: 70,
          width: 70,
          child: Container(
            decoration: BoxDecoration(
              border: hover
                  ? Border.all(color: globalUtility.primaryBg, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(20),
              color: hover ? widget.color : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                widget.icono,
                size: 50,
                color: hover
                    ? globalUtility.primaryBg
                    : globalUtility.secondaryText,
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
