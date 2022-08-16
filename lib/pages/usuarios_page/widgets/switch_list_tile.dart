import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({Key? key}) : super(key: key);

  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  bool switchListTileValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
      child: SizedBox(
        width: 40,
        child: SwitchListTile(
          key: widget.key,
          value: switchListTileValue,
          onChanged: (newValue) => setState(
            () => switchListTileValue = newValue,
          ),
          activeColor: const Color(0xFF3B864E),
          activeTrackColor: const Color(0xFF0DC773),
          dense: false,
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 90, 0),
        ),
      ),
    );
  }
}
