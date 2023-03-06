import 'package:flutter/material.dart';

class RouteEntry {
  RouteEntry(this.route);

  final Route<dynamic> route;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteEntry &&
          runtimeType == other.runtimeType &&
          route == other.route;

  @override
  int get hashCode => route.hashCode;
}
