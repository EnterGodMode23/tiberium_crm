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
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    NewTaskRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewTaskPage(),
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
    TaskRoute.name: (routeData) {
      final args = routeData.argsAs<TaskRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskPage(
          task: args.task,
          key: args.key,
        ),
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
/// [NewTaskPage]
class NewTaskRoute extends PageRouteInfo<void> {
  const NewTaskRoute({List<PageRouteInfo>? children})
      : super(
          NewTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewTaskRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

/// generated route for
/// [TaskPage]
class TaskRoute extends PageRouteInfo<TaskRouteArgs> {
  TaskRoute({
    required HarvestTask task,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TaskRoute.name,
          args: TaskRouteArgs(
            task: task,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskRoute';

  static const PageInfo<TaskRouteArgs> page = PageInfo<TaskRouteArgs>(name);
}

class TaskRouteArgs {
  const TaskRouteArgs({
    required this.task,
    this.key,
  });

  final HarvestTask task;

  final Key? key;

  @override
  String toString() {
    return 'TaskRouteArgs{task: $task, key: $key}';
  }
}
