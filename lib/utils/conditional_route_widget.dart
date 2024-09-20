import 'package:flutter/material.dart';

class ConditionalRouteWidget extends StatelessWidget {
  final List<String>? routes;
  final List<String>? routesExcluded;
  final TransitionBuilder builder;
  final Widget child;

  const ConditionalRouteWidget({
    super.key,
    this.routes,
    this.routesExcluded,
    required this.builder,
    required this.child,
  }) : assert(routes == null || routesExcluded == null,
            'Cannot include `routes` and `routesExcluded`. Please provide a list of routes to include or exclude, not both.');

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == null) {
      return child;
    }

    if ((routes != null && routes!.contains(currentRoute)) ||
        (routesExcluded != null && !routesExcluded!.contains(currentRoute))) {
      return builder(context, child);
    }

    return child;
  }
}
