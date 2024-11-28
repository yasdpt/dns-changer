import 'package:equatable/equatable.dart';

class NetworkInterfaceModel extends Equatable {
  final String name;
  final String adminState;
  final String state;
  final String type;
  final bool? ipv6Enabled;
  final String dnsServers;

  const NetworkInterfaceModel({
    this.name = "",
    this.adminState = "",
    this.state = "",
    this.type = "",
    this.ipv6Enabled,
    this.dnsServers = "",
  });

  NetworkInterfaceModel copyWith({
    String? name,
    String? adminState,
    String? state,
    String? type,
    bool? ipv6Enabled,
    String? dnsServers,
  }) =>
      NetworkInterfaceModel(
        name: name ?? this.name,
        adminState: adminState ?? this.adminState,
        state: state ?? this.state,
        type: type ?? this.type,
        ipv6Enabled: ipv6Enabled,
        dnsServers: dnsServers ?? this.dnsServers,
      );

  @override
  List<Object?> get props =>
      [name, adminState, state, type, ipv6Enabled, dnsServers];
}
