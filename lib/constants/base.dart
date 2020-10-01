import 'package:flutter/material.dart';

class Base {
  bool _isBusy = false;

  get isBusy => _isBusy;
  set isBusy(bool value) {
    this._isBusy = value;
  }

  Widget verticalSeparator({double max = 1}) {
    return SizedBox(
      height: max * 10,
    );
  }
}
