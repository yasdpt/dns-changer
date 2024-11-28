import 'package:dns_changer/src/models/network_interface_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interface_controller.g.dart';

@riverpod
class InterfaceController extends _$InterfaceController {
  @override
  NetworkInterfaceModel build() => const NetworkInterfaceModel();

  void setCurrentInterface(NetworkInterfaceModel interface) {
    state = interface;
  }

  void setIPV6Status(bool? isEnabled) {
    state = state.copyWith(ipv6Enabled: isEnabled);
  }
}
