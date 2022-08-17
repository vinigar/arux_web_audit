import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableTest extends StatefulWidget {
  const ExpandableTest({Key? key}) : super(key: key);

  @override
  State<ExpandableTest> createState() => _ExpandableTestState();
}

class _ExpandableTestState extends State<ExpandableTest> {
  @override
  Widget build(BuildContext context) {
    bool expanded = false;
    return Column(
      children: [
        Center(
            child: Container(
          color: Colors.green,
          width: 300,
          height: 100,
          child: ExpandablePanel(
            header: const Text("Header"),
            collapsed: const SizedBox(
              height: 0,
              width: 0,
            ),
            expanded: Row(
              children: const [Text("Expanded")],
            ),
          ),
        )),
        SizedBox(
          height: 200,
          width: 200,
          child: ExpansionPanelList(
            children: [
              ExpansionPanel(
                isExpanded: expanded,
                headerBuilder: (context, isOpen) {
                  return InkWell(
                    child: const SizedBox(
                        height: 100, width: 100, child: Text("hello closed")),
                    onTap: () {
                      if (expanded) {
                        expanded = false;
                        setState(() {});
                      } else {
                        expanded = true;
                        setState(() {});
                      }
                    },
                  );
                },
                body: const SizedBox(height: 100, width: 100, child: Text("1")),
              ),
            ],
          ),
        )
      ],
    );
  }
}
