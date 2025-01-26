// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    HarvestTaskRoute.name: (routeData) {
      final args = routeData.argsAs<HarvestTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HarvestTaskPage(
          task: args.task,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    MainTaskRoute.name: (routeData) {
      final args = routeData.argsAs<MainTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainTaskPage(
          task: args.task,
          key: args.key,
        ),
      );
    },
    NewPlanRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewPlanPage(),
      );
    },
    NewTaskRoute.name: (routeData) {
      final args = routeData.argsAs<NewTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewTaskPage(
          args.currRole,
          key: args.key,
        ),
      );
    },
    ProcessingTaskRoute.name: (routeData) {
      final args = routeData.argsAs<ProcessingTaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProcessingTaskPage(
          task: args.task,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    ScheduleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SchedulePage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HarvestTaskPage]
class HarvestTaskRoute extends PageRouteInfo<HarvestTaskRouteArgs> {
  HarvestTaskRoute({
    required HarvestTask task,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HarvestTaskRoute.name,
          args: HarvestTaskRouteArgs(
            task: task,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HarvestTaskRoute';

  static const PageInfo<HarvestTaskRouteArgs> page =
      PageInfo<HarvestTaskRouteArgs>(name);
}

class HarvestTaskRouteArgs {
  const HarvestTaskRouteArgs({
    required this.task,
    this.key,
  });

  final HarvestTask task;

  final Key? key;

  @override
  String toString() {
    return 'HarvestTaskRouteArgs{task: $task, key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainTaskPage]
class MainTaskRoute extends PageRouteInfo<MainTaskRouteArgs> {
  MainTaskRoute({
    required MainTask task,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MainTaskRoute.name,
          args: MainTaskRouteArgs(
            task: task,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'MainTaskRoute';

  static const PageInfo<MainTaskRouteArgs> page =
      PageInfo<MainTaskRouteArgs>(name);
}

class MainTaskRouteArgs {
  const MainTaskRouteArgs({
    required this.task,
    this.key,
  });

  final MainTask task;

  final Key? key;

  @override
  String toString() {
    return 'MainTaskRouteArgs{task: $task, key: $key}';
  }
}

/// generated route for
/// [NewPlanPage]
class NewPlanRoute extends PageRouteInfo<void> {
  const NewPlanRoute({List<PageRouteInfo>? children})
      : super(
          NewPlanRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPlanRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewTaskPage]
class NewTaskRoute extends PageRouteInfo<NewTaskRouteArgs> {
  NewTaskRoute({
    required Role currRole,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NewTaskRoute.name,
          args: NewTaskRouteArgs(
            currRole: currRole,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NewTaskRoute';

  static const PageInfo<NewTaskRouteArgs> page =
      PageInfo<NewTaskRouteArgs>(name);
}

class NewTaskRouteArgs {
  const NewTaskRouteArgs({
    required this.currRole,
    this.key,
  });

  final Role currRole;

  final Key? key;

  @override
  String toString() {
    return 'NewTaskRouteArgs{currRole: $currRole, key: $key}';
  }
}

/// generated route for
/// [ProcessingTaskPage]
class ProcessingTaskRoute extends PageRouteInfo<ProcessingTaskRouteArgs> {
  ProcessingTaskRoute({
    required ProcessingTask task,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProcessingTaskRoute.name,
          args: ProcessingTaskRouteArgs(
            task: task,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProcessingTaskRoute';

  static const PageInfo<ProcessingTaskRouteArgs> page =
      PageInfo<ProcessingTaskRouteArgs>(name);
}

class ProcessingTaskRouteArgs {
  const ProcessingTaskRouteArgs({
    required this.task,
    this.key,
  });

  final ProcessingTask task;

  final Key? key;

  @override
  String toString() {
    return 'ProcessingTaskRouteArgs{task: $task, key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SchedulePage]
class ScheduleRoute extends PageRouteInfo<void> {
  const ScheduleRoute({List<PageRouteInfo>? children})
      : super(
          ScheduleRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScheduleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
