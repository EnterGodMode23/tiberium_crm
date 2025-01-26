import 'package:flutter/material.dart';

class TaskDetailsCard extends StatelessWidget {
  final String destination;
  final int priority;
  final String status;

  const TaskDetailsCard({
    required this.destination,
    required this.priority,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(
                    context,
                    icon: Icons.location_on_outlined,
                    label: 'Destination',
                    value: destination,
                  ),
                  _buildPriorityBadge(priority),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoItem(
                context,
                icon: Icons.pending_actions_outlined,
                label: 'Status',
                value: status,
              ),
            ],
          ),
        ),
      );

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );

  Widget _buildPriorityBadge(int priority) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _getPriorityColor(priority),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.flag_outlined,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              'P$priority',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red[400]!;
      case 2:
        return Colors.orange[400]!;
      case 3:
        return Colors.green[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
