---
layout: post
title: Flutterとは？
subtitle: Flutterを選択する理由とその経緯
description:
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
image: "/assets/images/newbusinessflowchart/pro.png)"
category:
  - Engineering
tags:
  - Flutter
date: '2024-02-10 10:08:59 +0900'
---

## Fulutterとは

Flutter（フラッター）は、Googleが開発したオープンソースのUIのSDK（ソフトウェア開発キット）です。モバイルアプリの開発を支援するライブラリで、2018年にリリースされました。
Flutterは、マルチプラットフォームでのアプリケーション開発を行うフレームワークです。
マルチプラットフォームとはAndroidやiOSなどのモバイル向けのアプリケーションだけでなく、Linux、Mac、Windows向けのデスクトップアプリやWebアプリケーションを一貫して開発できるものです。
しかし、マルチプラットフォームやクロスプラットフォームと呼ばれるフレームワークはFulutterだけではありません。

## マルチプラットフォームのフレームワーク

一般的に有名なものや、開発を行う際に選択されやすいものを紹介します。

- Flutter
- React Native
- Xamarin
- Unity

この中での簡単なフレームワークの選択するべき要素を挙げます。

ゲーム制作を行う場合Unity一択になります。他の選択肢を選ぶ必要がないです。
Windowsで開発している、特にUIに気を遣う必要はない場合Xamarinでいいでしょう。

しかし、ゲーム制作をして３Dを使用しない、基本的にMacOSで開発を行っている場合
これらの選択を行うことは、正しいとはいえません。

### FlutterとReact Nativeの比較

FlutterとReact Nativeはどちらを選択してもいいと言える似た性能を持っています。

React NativeはWeb技術をベースに設計されています。
そのため、Webベースでの開発ではReact Nativeは開発しやすいものであり、開発をおこないやすいものでしょう。

しかしアプリケーションを作成する場合は、Flutterを選択しておくと、どのOSやプラットフォームでも統一された見た目で開発を行いやすいと言えます。

### Flutter、React Native、Xamarinの比較

以下は、Flutterと他のマルチプラットフォームフレームワーク（React NativeとXamarin）を比較するための機能一覧のマークダウン表です

| 機能                  | Flutter                    | React Native               | Xamarin                    |
|-----------------------|----------------------------|----------------------------|----------------------------|
| プログラミング言語    | Dart                       | JavaScript (React)        | C# (XAML, .NET)           |
| 学習曲線 | やや急 | やや緩やか | 緩やか (C#の知識があれば比較的容易)|
| UI構築                | Widgetに基づくUI構築       | コンポーネント指向 (JSX) | XAMLに基づくUI構築         |
| パフォーマンス        | 高速なネイティブパフォーマンス | ネイティブコンポーネントの使用 | ネイティブコンポーネントの使用 |
| ネイティブ機能アクセス | プラグインを使用してネイティブ機能にアクセス | プラグインを使用してネイティブ機能にアクセス | プラグインを使用してネイティブ機能にアクセス |
| コードの共有率         | 100%共有可能                | 一部のコードを共有可能      | 一部のコードを共有可能      |
| リロード速度          | Hot Reloadを提供           | Fast Refreshを提供        | Xamarin Hot Reloadを提供   |
| コミュニティサポート    | アクティブなコミュニティ    | アクティブなコミュニティ    | アクティブなコミュニティ    |
| ドキュメント            | 公式ドキュメントが豊富     | 公式ドキュメントが豊富      | 公式ドキュメントが豊富      |
| 採用状況 | 増加傾向 | 横ばい | 横ばい |
| 求人件数 | 増加傾向 | 横ばい | 横ばい |
| 年収 | やや高い | やや低い | やや低い |
| 将来性 | 有望 | やや不透明 | 安定 |

どのフレームワークを選ぶべきかは、プロジェクトの要件や開発する人のスキルセットによって異なります。

- 高速なパフォーマンスと美しいUI表現が求められる場合はFlutterが適しています。

- すでにJavaScriptやwebの知識がある開発者が多い場合はReact Nativeが適しています。

- windowsを中心に開発し、C#の知識があり、ネイティブUIを利用したい場合はXamarinが適しています。

## Flutterを使用して開発を行おうと思った経緯

今回なぜFlutterを選択するべきで、ブログで紹介をしようと思ったのというと
BlueSkyというtwitterによく似たアプリケーションが広く公開され
apiを使用して簡単にツイートできるアプリケーションを作成しようと思ったからです。

webアプリケーションを作成して公開するのではなく、デスクトップアプリケーションで簡単にポストできるものを作成するのであれば
クロスプラットフォームでよりアプリケーション側に最適化された技術を選択したい為、Flutterを選択しました。

## Flutterまとめ：注目度と将来性、そして注意点

近年、特に注目を集めているFlutter。
年収が上がりやすいフレームワークとして話題になり、マルチプラットフォーム技術者の不足も叫ばれています。
求人でもFlutter関連の案件が頻繁に見られるようになりました。

しかし、Google社員でも技術者でもない私たちにとって、このフレームワークの得意不得意を正しく把握することは非常に重要です。
どのようなコミュニティが存在し、どのように開発が行われているのかを知ることも欠かせません。

例えば、Flutterのブログ記事を書いた経験から、中国での利用が多いことが分かりました。セキュリティやプラグインを扱う際、言語の壁が立ちはだかることもあるでしょう。

実際に求人が増加しているという調査結果は、非常に有益な情報でした。今回詳細な調査を行ったことで、今後の開発にも役立ちそうです。

そして、私の記事が皆さんのFlutter選択における不安を少しでも払拭できれば幸いです。

最後まで読んでいただきありがとうございました。

### 参考資料

- Flutter公式サイト: [https://flutter.dev/](https://flutter.dev/)

- React Native公式サイト: [https://reactnative.dev/](https://reactnative.dev/)

- Xamarin公式サイト: [https://www.xamarin.com/](https://www.xamarin.com/)
