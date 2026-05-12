import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarGolden(
    fileNamePrefix: 'bookmarks_navigation_bar',
    description: 'Bookmarks NavigationBar',
    selectedIndex: 1,
    bodyLabel: 'ブックマーク',
  );
}
