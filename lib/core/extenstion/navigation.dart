import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<void> pushTo(BuildContext context, Widget widget) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  void pushReplaceTo(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }
}
