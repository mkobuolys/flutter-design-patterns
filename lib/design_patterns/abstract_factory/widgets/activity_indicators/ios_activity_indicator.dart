import 'package:flutter/cupertino.dart';

import '../iactivity_indicator.dart';

class IosActivityIndicator implements IActivityIndicator {
  @override
  Widget render() {
    return const CupertinoActivityIndicator();
  }
}
