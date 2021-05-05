import 'package:equatable/equatable.dart';

class UpdateModel extends Equatable {
  final int lastUpdate;

  UpdateModel({
    required this.lastUpdate
  });

  @override
  List<Object?> get props => [lastUpdate];

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
        lastUpdate: (json['lastUpdate'] as num).toInt()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastUpdate': lastUpdate
    };
  }

  final int oneDay = 86400000;

  bool get timeSpanIsLongerThan24h {
    return ((DateTime.now().millisecondsSinceEpoch - lastUpdate) > oneDay);
  }
}