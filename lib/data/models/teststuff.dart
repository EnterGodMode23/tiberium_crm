import 'package:tiberium_crm/data/models/person.dart';
import 'package:tiberium_crm/data/models/task.dart';
import 'package:tiberium_crm/data/task_type.dart';

import '../user_role.dart';

const Person testguy = Person(
    fio: 'Guy Test',
    role: UserRole.productionManager,
    photoLink: 'y',
    id: '123');
const List<Task> tasks = [
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.harvest,
    status: TaskStatus.IN_PROGRESS,
    kilosToProcess: 45546,
    destination: 'Mining District #2',
    priority: 1,
    creationDate: '20-02-1999',
    id: '1234',
  ),
  Task(
    operator: testguy,
    curator: testguy,
    type: TaskType.processing,
    status: TaskStatus.DONE,
    kilosToProcess: 123,
    destination: 'Mining District #4',
    priority: 2,
    creationDate: '02-03-1999',
    id: '4532',
  ),

];
