import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './route_handlers.dart';

class Routes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        // ignore: missing_return
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define('/', handler: rootHandler);
    router.define("/news", handler: newsRouteHandler);
    router.define("/program", handler: programRouteHandler);
    router.define("/info", handler: infoRouteHandler);
    router.define("/sponsor", handler: sponsorsRouteHandler);
    router.define("/content/:id", handler: contentViewerRouteHandler);
    router.define("/settings", handler: settingsRouteHandler);
  }
}
