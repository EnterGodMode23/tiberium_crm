enum Role {
  salesManager,
  harvestManager,
  processingManager,
  harvestOperator,
  processingOperator
}

extension RoleExtension on Role {
  String toStringX() {
    switch (this) {
      case Role.salesManager:
        return 'SALES_MANAGER';
      case Role.harvestManager:
        return 'HARVEST_MANAGER';
      case Role.processingManager:
        return 'PROCESSING_MANAGER';
      case Role.harvestOperator:
        return 'HARVEST_OPERATOR';
      case Role.processingOperator:
        return 'PROCESSING_OPERATOR';
    }
  }

  static Role fromString(String roleString) {
    switch (roleString) {
      case 'SALES_MANAGER':
        return Role.salesManager;
      case 'HARVEST_MANAGER':
        return Role.harvestManager;
      case 'PROCESSING_MANAGER':
        return Role.processingManager;
      case 'HARVEST_OPERATOR':
        return Role.harvestOperator;
      case 'PROCESSING_OPERATOR':
        return Role.processingOperator;
      default:
        throw ArgumentError('Invalid role string: $roleString');
    }
  }
}
