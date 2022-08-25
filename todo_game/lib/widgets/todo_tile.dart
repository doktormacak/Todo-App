import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoTile extends StatelessWidget {


  TodoTile({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
            child: Text("AA"),
          ),
           Checkbox(
            onChanged: null,
            value: true,
          )
        ],
      ),
    );
  }
}
