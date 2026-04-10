final List<Map<String, dynamic>> sharedTasks = [
  {
    'title': 'Finish Assignment',
    'status': 'In Process',
    'dueDate': '2026-04-14',
    'done': false,
  },
  {
    'title': 'Study Flutter',
    'status': 'Started',
    'dueDate': '2026-04-20',
    'done': false,
  },
];

final List<Map<String, dynamic>> sharedAssignments = [
  {
    'id': 1,
    'title': 'Flutter Basics Assignment',
    'description': 'Create a simple counter app',
    'dueDate': '2026-04-15',
    'totalMarks': 100,
  },
];

int totalStudySeconds = 0;

String formatDaysLeft(String dueDate) {
  if (dueDate.isEmpty) return '';
  final DateTime? due = DateTime.tryParse(dueDate);
  if (due == null) return '';
  final int daysLeft = due.difference(DateTime.now()).inDays;
  if (daysLeft > 1) return '$daysLeft days left';
  if (daysLeft == 1) return '1 day left';
  if (daysLeft == 0) return 'Due today';
  return '${daysLeft.abs()} days overdue';
}

void mirrorAssignmentToTask(Map<String, dynamic> assignment) {
  final int index = sharedTasks.indexWhere((task) => task['assignmentId'] == assignment['id']);
  final Map<String, dynamic> taskEntry = {
    'title': assignment['title'],
    'status': 'Started',
    'dueDate': assignment['dueDate'],
    'done': false,
    'assignmentId': assignment['id'],
  };

  if (index >= 0) {
    sharedTasks[index] = taskEntry;
  } else {
    sharedTasks.add(taskEntry);
  }
}

void removeTaskForAssignment(int assignmentId) {
  sharedTasks.removeWhere((task) => task['assignmentId'] == assignmentId);
}