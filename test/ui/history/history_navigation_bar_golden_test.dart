import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarGolden(
    fileNamePrefix: 'history_navigation_bar',
    description: 'History NavigationBar',
    selectedIndex: 2,
    bodyLabel: '閲覧履歴',
  );
}
