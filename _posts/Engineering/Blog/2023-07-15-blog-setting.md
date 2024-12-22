---
layout: post
title: JekyllとGithub pageでBLOGをリニューアル
date: 2023-07-15 13:40 +0900
categories:
    - Engineering
tags:
    - Blog
---

ついに、JekyllとGithub Pagesを使って、三年間放置していたブログをリニューアルしました。
前回のブログはHexoを選んでいたが、爆速で組んでアップデートが面倒になったので反省。
今回は整備のしやすそうなrubyで確認できるJekelly+githubPageで構築した。
なんか良さそうなブログテーマがあったからって理由で技術を選択するのは良くないよってことなんやな。

以下にその工程を詳しく紹介します。

## JekyllとGithub Pagesとは？

始める前に、JekyllとGithub Pagesについて少し説明しましょう。

Jekyllはシンプルでブログ対応の静的サイトジェネレーターで、さまざまな形式の生テキストファイルを含むテンプレートディレクトリを取り、それをコンバータとレンダラーにかけて、公開準備が整った完全な静的ウェブサイトを生成します。
一方、Github Pagesは、Githubが提供している静的ウェブサイトホスティングサービスです。このサービスは、個人、組織、またはプロジェクトのページをGitHubのリポジトリから直接ホスティングすることができます。
以下、githubPageの機能です。

- 個人、組織、プロジェクトページのホスティング: Github Pagesは、ユーザ名.github.ioという形式のURLでページをホストします。このURLは、個人のページ、組織のページ、またはプロジェクトのページとして使用することができます。
- 静的サイトのホスティング: Github Pagesは静的なウェブサイトのみをホストします。これは、HTML、CSS、JavaScript、画像などの静的ファイルを直接ブラウザに配信することを意味します。
- Jekyllの統合: Github Pagesは、静的サイトジェネレータであるJekyllと統合されています。これにより、Markdownファイルから直接ウェブサイトを生成することが可能になります。
- 無料のホスティング: Github Pagesは無料で使用することができます。しかしながら、公開可能なサイトの数やトラフィックには制限があります。
- カスタムドメインの使用: Github Pagesのサイトには、デフォルトでgithub.ioというドメインが使用されますが、独自のドメインを設定することも可能です。

そして、サーバーを意識せず,更新もローカルからコマンド一つで更新できるBLOGが作れるわけです。
ちょっとサーバー借りるのめんどいな、今すぐサービス立ち上げしたいなって思っている人におすすめです。

## Jekyllのセットアップ

Jekyllをセットアップするには、まずRubyをインストールする必要があります。
既にインストールされてる方はスキップで

まずRubyのインストール方法は、使用しているオペレーティングシステムにより異なります。
MacでのRubyのインストール方法を示します。
他のOSの方は公式を見てください。

1. **macOSの場合**

macOSにはデフォルトでRubyがインストールされていますが、
どうせ新規でインストールするなら最新の安定版あたりのバージョンをインストールしましょう。
バージョンを正しく管理するなら、`rbenv`や`rvm`といったバージョン管理ツールを使用することを**強く**お勧めします。
ここでは`rbenv`を使用したインストール方法を示します。

まずはHomebrewを使って`rbenv`をインストールします。
Homebrewがまだインストールされていない場合は、[公式ウェブサイト](https://brew.sh/)の指示に従ってインストールしてください。

```zsh
#check brew version
brew -v
```

Homebrewがインストールされていることを確認したら、次のコマンドを実行して`rbenv`をインストールします.

```zsh
brew install rbenv
```

そして、`rbenv`を初期化してPATHも通します。

```zsh
rbenv init
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
```

最後に、新しいターミナルウィンドウを開き、次のコマンドを実行してRubyをインストールします
今回は最新の安定版を選択しますが、公式を確認して安定バージョンを見て選択してください。

```zsh
rbenv install 3.2.2
rbenv global 3.2.2
```

2. **Windowsの場合**

Windowsの場合、RubyInstallerを使ってRubyをインストールすることができます。以下にその手順を示します：
まず、RubyInstallerの公式ウェブサイト(https://rubyinstaller.org/)にアクセスして、インストーラをダウンロードします。
ダウンロードしたインストーラを実行し、指示に従ってインストールを進めてください。基本的には全てデフォルトのオプションで問題ありません。
インストールが完了したら、新しいコマンドプロンプトウィンドウを開き、`ruby -v`コマンドを実行して、Rubyが正しくインストールされたことを確認します。
これらの手順はあくまで一例であり、使用するシステムや個々の環境により異なる可能性があります。実際に作業を行う際は、公式ドキュメンテーションや最新のガイドラインに従ってください。

Rubyをインストールしたら、次のコマンドを使ってJekyllとBundlerをインストールできます：

## Jekyll&bundler install

```zsh
gem install jekyll bundler
```

インストールが完了したら、次のコマンドを使って新しいJekyllサイトを作成できます

```ruby
jekyll new my-awesome-site
```

## Github Pagesの設定

Jekyllのサイトがセットアップされたら、次にGithub Pagesでホストするようにします。
これには、Githubで新しいリポジトリを作成します。リポジトリ名は 'yourusername.github.io' とします。
今回自分はorganaizationで作ってるのでリポジトリ名はgithub.ioにしてないです。(しなくてもできる。)
次に、ローカルマシン上のJekyllサイトに移動し、次のコマンドを実行してgitを初期化し、Githubリポジトリに接続します：

```zsh
git init
git remote add origin https://github.com/username/username.github.io
```

## サイトをGithubにプッシュ

サイトがGithubに接続されたら、次のコマンドを使ってサイトをGithubにプッシュします：

```zsh
git add --all
git commit -m "Initial commit"
git push -u origin master
```

これで完了です！
サイトは 'https://username.github.io' でライブになるはずです。
説明が足りなかったらごめん。本で正しいコマンド全部は書くようにします。

JekyllとGithub Pagesはブログを素早く設定するには非常に有用なツールです。
自分のように放置していたブログを復活させる場合や、新しくブログを始める場合にも、ぜひ試してみてください。
