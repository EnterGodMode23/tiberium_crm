class CreateNewMainTaskReq {
  String? processingManagerId;
  String? harvestManagerId;
  double? targetKilosToSale;
  int? priority;
  String? destination;
  String? status;

  CreateNewMainTaskReq({
    this.processingManagerId,
    this.harvestManagerId,
    this.targetKilosToSale,
    this.priority,
    this.destination,
    this.status,
  });

  CreateNewMainTaskReq.fromJson(Map<String, dynamic> json) {
    processingManagerId = json['processing_manager_id'];
    harvestManagerId = json['harvest_manager_id'];
    targetKilosToSale = json['target_kilos_to_sale'];
    priority = json['priority'];
    destination = json['destination'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['processing_manager_id'] = processingManagerId;
    data['harvest_manager_id'] = harvestManagerId;
    data['target_kilos_to_sale'] = targetKilosToSale;
    data['priority'] = priority;
    data['destination'] = destination;
    data['status'] = status;
    return data;
  }
}
