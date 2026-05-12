import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarGolden(
    fileNamePrefix: 'drug_navigation_bar',
    description: 'Drug detail NavigationBar',
    selectedIndex: 0,
    bodyLabel: '医薬品詳細',
  );
}
