import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class BrowserNoDragBehavior extends ScrollBehavior {
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.mouse,
      };
}
