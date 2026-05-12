import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarGolden(
    fileNamePrefix: 'disease_navigation_bar',
    description: 'Disease detail NavigationBar',
    selectedIndex: 0,
    bodyLabel: '疾患詳細',
  );
}
