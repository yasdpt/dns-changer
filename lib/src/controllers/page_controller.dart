import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_controller.g.dart';

@riverpod
class PageController extends _$PageController {
  @override
  int build() => 0;

  void setPage(int page) {
    if (page != state) {
      state = page;
    }
  }
}
