import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

Future showAlertDialog(BuildContext context, String messageContent,
    List<String> actions, String? title) {
  AlertDialog dialogAlert = AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24, 24, 20, 0),
    buttonPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    title: title != null
        ? Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          )
        : null,
    content: Text(messageContent),
    actions: [
      Row(
        children: [
          if (actions.length > 1)
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorCustom.buttonSecondaryColor),
                  ),
                  child: Text(actions[1]),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
            ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
                child: Text(actions[0]),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ),
        ],
      )
    ],
  );

  Future<dynamic> futureValue = showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogAlert;
      });

  return futureValue;
}
