import '/utilities/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpansionTileTemplate extends StatefulWidget {
  const ExpansionTileTemplate(
      {Key? key, required this.questionTitle, required this.answer})
      : super(key: key);

  final String questionTitle;
  final String answer;

  @override
  State<ExpansionTileTemplate> createState() => _ExpansionTileTemplateState();
}

class _ExpansionTileTemplateState extends State<ExpansionTileTemplate> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.deepGray)),
      child: ExpansionTile(
        backgroundColor: MyColors.myWhite,
        textColor: MyColors.primaryColor,
        title: Text(
          widget.questionTitle,
          style: const TextStyle(fontSize: 16.0, color: MyColors.primaryColor),
        ),
        trailing: CircleAvatar(
            radius: 13,
            backgroundColor: MyColors.myYellow,
            child: _customTileExpanded
                ? const Icon(
                    CupertinoIcons.minus,
                    color: MyColors.colorWhite,
                    size: 15,
                  )
                : const Icon(
                    CupertinoIcons.add,
                    color: MyColors.colorWhite,
                    size: 15,
                  )),
        onExpansionChanged: (bool expanded) {
          _customTileExpanded = expanded;
          setState(() {});
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.answer,
              style: const TextStyle(
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}
