import 'dart:js_interop';

import 'package:web/web.dart' as web;

void setupRefreshRedirect() {
  web.window.onbeforeunload = ((web.Event event) {
    web.window.history.replaceState(null, '', '/');
  }).toJS;
}
