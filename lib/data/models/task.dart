import 'package:tiberium_crm/data/models/person.dart';
import 'package:tiberium_crm/data/task_type.dart';

 class Task {
  final Person operator;
  final Person curator;
  final TaskType type;
  final TaskStatus status;
  final int kilosToProcess;
  final String destination;
  final int priority;
  final String creationDate;
  final String id;

  const Task({
    required this.operator,
    required this.curator,
    required this.type,
    required this.status,
    required this.kilosToProcess,
    required this.destination,
    required this.priority,
    required this.creationDate,
    required this.id,
  });
}
