import 'package:flutter/material.dart';

import '../data/device_keyboard.dart';

class DeviceKeyboardWidget extends StatelessWidget {
  final DeviceKeyboard keyboard;

  const DeviceKeyboardWidget({
    @required this.keyboard,
  });

  Widget _row(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12),
      child: Row(children: children),
    );
  }

  List<Widget> _letters(List<String> letters, Color backgroundColor, Color foregroundColor) {
    return letters.map<Widget>((letter) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: DeviceKeyboardButton(
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 14,
                color: foregroundColor,
              ),
            ),
            backgroundColor: backgroundColor,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: keyboard.height,
      color: keyboard.backgroundColor,
      child: Column(
        children: <Widget>[
          _row(_letters(
            ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
            keyboard.button1BackgroundColor,
            keyboard.button1ForegroundColor,
          )),
          _row(_letters(
            ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
            keyboard.button1BackgroundColor,
            keyboard.button1ForegroundColor,
          )),
          _row([
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: DeviceKeyboardButton(
                child: Icon(
                  Icons.keyboard_capslock,
                  color: keyboard.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: keyboard.button2BackgroundColor,
              ),
            ),
            ..._letters(
              ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
              keyboard.button1BackgroundColor,
              keyboard.button1ForegroundColor,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: DeviceKeyboardButton(
                child: Icon(
                  Icons.backspace,
                  color: keyboard.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: keyboard.button2BackgroundColor,
              ),
            ),
          ]),
          _row([
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: DeviceKeyboardButton(
                child: Text(
                  '123',
                  style: TextStyle(
                    fontSize: 14,
                    color: keyboard.button2ForegroundColor,
                  ),
                ),
                backgroundColor: keyboard.button2BackgroundColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: DeviceKeyboardButton(
                child: Icon(
                  Icons.insert_emoticon,
                  color: keyboard.button2ForegroundColor,
                  size: 16,
                ),
                backgroundColor: keyboard.button2BackgroundColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: DeviceKeyboardButton(
                  child: Text(
                    'space',
                    style: TextStyle(fontSize: 14.0, color: keyboard.button2ForegroundColor),
                  ),
                  backgroundColor: keyboard.button2BackgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: DeviceKeyboardButton(
                child: Text(
                  'return',
                  style: TextStyle(fontSize: 14.0, color: keyboard.button2ForegroundColor),
                ),
                backgroundColor: keyboard.button2BackgroundColor,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class DeviceKeyboardButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const DeviceKeyboardButton({
    @required this.backgroundColor,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      alignment: Alignment.center,
      child: child,
    );
  }
}
