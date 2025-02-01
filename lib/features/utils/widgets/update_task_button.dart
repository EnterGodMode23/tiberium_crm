import 'package:flutter/material.dart';

class UpdateTaskButton extends StatelessWidget {
  final String status;
  final VoidCallback callback;

  const UpdateTaskButton({
    super.key,
    required this.status,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) => status != 'DONE'
      ? Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: callback,
            child: Text(
              '${status == 'TO_DO' ? 'Start' : 'Finish'} Task',
              style: const TextStyle(fontSize: 32, color: Colors.black),
            ),
          ),
        )
      : const SizedBox.shrink();
}
