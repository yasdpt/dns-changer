import 'package:dns_changer/src/models/dns_provider_model.dart';
import 'package:dns_changer/src/util/app_consts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dns_provider_controller.g.dart';

@riverpod
class DNSProviderController extends _$DNSProviderController {
  @override
  DNSProviderModel build() => AppConsts.myDNSProviders.first;

  void setCurrentDNSProvider(DNSProviderModel newDNSProvidre) {
    state = newDNSProvidre;
  }
}
