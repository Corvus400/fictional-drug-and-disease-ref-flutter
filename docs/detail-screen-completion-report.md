# 詳細画面 Golden/実機相当検証 完了報告

## 実装済み Phase

- 医薬品詳細のヒーロー画像のみ `Size=Original` に変更し、検索画面と関連カードのサムネイルは `Size=M` を維持。
- 医薬品詳細ヒーロー画像と疾患詳細の関連医薬品画像を、検索画面と同じカード画像キャッシュ経路へ統一。
- 医薬品詳細ヒーロー画像の表示位置、アスペクト比、タップ時の Hero 遷移プレビューを調整。
- 関連タブの疾患/医薬品カードを、表示内容に合わせた幅とパディングへ調整。疾患カードから不要な画像領域を削除し、医薬品カードには検索画面同等のサムネイルを表示。
- セクション罫線、PK パラメータ、重要な副作用、空の注意カテゴリ、iPad section rail、FontWeight/文字サイズを Detail Spec に合わせて調整。
- 副作用頻度などの enum 直出しを l10n 経由の日本語表示に変換。
- Markdown 指定フィールドを `flutter_markdown_plus` で描画し、3列/複数列テーブル内の本文だけが pill 風に見える問題を解消。
- iOS integration test が flavor の `FLUTTER_TARGET` 上書きで `main_dev.dart` を直接起動していた問題を修正し、テスト listener を起動できるようにした。
- integration smoke test を「起動のみ」から「検索文字入力、検索実行、医薬品詳細遷移、ヒーロー画像領域確認」まで拡張。

## 未実装 Phase

- なし。

## 成功基準

- `flutter analyze`: pass
- `flutter test`: pass
- `flutter test --tags golden -j 1`: pass
- iPad Simulator integration test: `トレデキム` 入力、検索、`drug_0080` 詳細遷移、ヒーロー画像領域確認まで pass
- iPhone 17 Simulator integration test: `トレデキム` 入力、検索、`drug_0080` 詳細遷移、ヒーロー画像領域確認まで pass
- wrapper install: Android device、物理 iPad、iPhone 17 Simulator、iPad Pro 11-inch Simulator へのインストール pass
- wrapper インストール後の通常アプリ起動: iPhone/iPad Simulator とも検索画面まで描画され、白画面停止なし

## 意図的逸脱

- Detail Spec の関連タブでは疾患カードにも画像領域があるが、最新指示に従い、画像を持たない疾患カードから画像領域を削除した。
- Detail Spec の関連医薬品カードは大きめのカード画像領域を持つが、最新指示に従い、検索画面と同じ横長カード構成と `Size=M` サムネイル表示へ変更した。

## 残リスク

- wrapper インストール後の通常アプリでは起動表示をスクリーンショットで確認した。検索から詳細遷移までの操作検証は、同じ修正後コードに対する iPhone/iPad integration test で担保している。
- 物理 iPad へのインストール時に `devicectl` の provider warning が出るが、最終的な install は成功している。
