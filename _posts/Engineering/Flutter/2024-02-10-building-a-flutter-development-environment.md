---
layout: post
title: Flutter開発環境構築
subtitle: VSCodeで始める初めてのFlutterアプリ開発
description:
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
image: "/assets/images/newbusinessflowchart/pro.png)"
category:
  - Engineering
tags:
  - Flutter
    - 環境構築
date: '2024-02-10 11:08:59 +0900'
---

## VSCodeで始める初めてのFlutterアプリ開発

**Flutter**は、Googleが開発したオープンソースのクロスプラットフォームフレームワークで、Android、iOS、Webアプリを単一のコードベースで開発できます。
近年、その注目度と需要が高まっており、多くの開発者がFlutterアプリ開発に参入しています。

本記事では、VSCodeを使ってFlutter開発環境を構築し、初めてのFlutterアプリ開発に挑戦するまでの手順を丁寧に解説します。
VSCodeは無料で使える軽量なコードエディタであり、初心者でも使いやすいのでおすすめです。

### 前提条件

* この記事ではMacOSで開発しているので、Macでの構築を元にして解説します。
* VisialStudioCode（VSCode）で環境を構築します。
* デスクトップアプリケーションを作成する目的で構築します、AndroidやiOSのappでは追加の作業が必要になるかもしれません。
* cocoapodのインストール `brew install cocoapods`
* Xcodeのインストール:[https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)


### VSCodeのインストール

VSCode公式ウェブサイトからVSCodeをダウンロードし、インストールします。

* VSCode公式ウェブサイト: [https://code.visualstudio.com/](https://code.visualstudio.com/)

#### VSCodeでのDart拡張のインストール

VSCodeを起動し、拡張機能(⇧⌘X) Marketplace から「Dart」拡張機能を検索してインストールします。

* VSCodeのDart拡張:
[https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)

#### VSCodeでのFluttr拡張のインストール

VSCodeを起動し、拡張機能(⇧⌘X)  Marketplace から「Flutter」拡張機能を検索してインストールします。

* VSCodeのFlutter拡張:
[https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

### Flutter SDKのインストール

VSCodeの準備が整ったのでFlutter SDKを用意してきます。
VSコードから行える簡略化された方法でインストールしていきます

インストール場所の作成$HOME/developmentを作成

```zsh
mkdir $HOME/development
```

VSCodeを起動してコマンドパレットを起動する（⇧⌘P）

コマンドパレットにflutterを入力してNew Projectを選択
![cmd-palett-image](https://github.com/tecmah/tecmah-blogv2/assets/11237144/ec0b9bd3-49ed-4974-99d8-0519ebabaa53)

VSCodeの右下のポップアップでFlutter SDKの場所がわからないと出る為
[Download SDK]をクリックしてFlutter SDKをダウンロードします
ダウンロードする場所は先ほど作成したファイルの中を選択してください

ファイルの場所が決まるとダウンロードを行う為、Clone Flutterをクリック

Flutter SDKのダウンロードが終わったらパスを問われるのでYESを押す

```zsh
Do you want to add the Flutter SDK to PATH so it's accessible
in external terminals?
```

ここまでできればFlutterが使用できるはずなのでコマンドで確認


シェルの確認(zsh想定のコマンド)

```zsh
echo $SHELL
```

パスを通す

```zsh
echo export PATH=\"\$PATH:\$HOME/development/flutter/bin\" >> ~/.zshrc
```

flutterをすべてのターミナル ウィンドウで有効にする為にVSCodeを再起動します。

すべての前提条件と Flutter SDK をインストールしている場合は、
デスクトップ用 macOS で Flutter の開発を開始できるはずです。

### 新規プロジェクトの作成

VSCodeで（⇧⌘P）を押すかコマンドパレットを起動する
「Flutter」もしくは「Flutter: New Project」を入力します。

[Flutter: New Project]を選択します。

### アプリの実行

VSCodeでデバッグボタンをクリックするか、「F5」キーを押すと、アプリがシミュレータまたは実機で実行されます。

### 7. デバッグ

VSCodeのデバッグ機能を使って、アプリのデバッグを行うことができます。

### 8. 次のステップ

* チュートリアルを参考に、Flutterの基本的な操作を学びましょう。
* サンプルコードを参考に、自分のアプリ開発に挑戦しましょう。
* Flutterコミュニティに参加して、情報収集や質問を行いましょう。

## まとめ

VSCodeを使ってFlutter開発環境を構築し、初めてのFlutterアプリ開発に挑戦する方法を解説しました。本記事を参考に、Flutter開発を始めてみましょう。

### 参考資料

* Flutter公式ドキュメント: [https://flutter.dev/docs](https://flutter.dev/docs)
* Flutter Cookbook: [https://flutter.dev/docs/cookbook](https://flutter.dev/docs/cookbook)
* Flutter Awesome: [https://flutterawesome.com/](https://flutterawesome.com/)
