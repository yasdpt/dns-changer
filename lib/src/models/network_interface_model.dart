import 'package:equatable/equatable.dart';

class NetworkInterfaceModel extends Equatable {
  final String name;
  final String adminState;
  final String state;
  final String type;
  final String dnsServers;

  const NetworkInterfaceModel({
    this.name = "",
    this.adminState = "",
    this.state = "",
    this.type = "",
    this.dnsServers = "",
  });

  NetworkInterfaceModel copyWith({
    String? name,
    String? adminState,
    String? state,
    String? type,
    String? dnsServers,
  }) =>
      NetworkInterfaceModel(
        name: name ?? this.name,
        adminState: adminState ?? this.adminState,
        state: state ?? this.state,
        type: type ?? this.type,
        dnsServers: dnsServers ?? this.dnsServers,
      );

  @override
  List<Object?> get props => [name, adminState, state, type, dnsServers];
}
