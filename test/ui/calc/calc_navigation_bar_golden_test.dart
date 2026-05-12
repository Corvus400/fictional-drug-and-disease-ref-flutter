import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarGolden(
    fileNamePrefix: 'calc_navigation_bar',
    description: 'Calculation NavigationBar',
    selectedIndex: 3,
    bodyLabel: '計算ツール',
  );
}
