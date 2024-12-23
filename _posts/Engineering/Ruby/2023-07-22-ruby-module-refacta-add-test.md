---
layout: post
title: Ruby モジュールのリファクタリングとテストの追加
description: 本記事では、ソフトウェア開発におけるリファクタリングの一過程を詳細に解説します。具体的には、コード内の重複部分の特定、重複部分のメソッド抽出、抽出したメソッドの適切な配置、重複部分のメソッド呼び出しへの置き換え、そして最後にリファクタリング後の動作確認について説明しています。それぞれのステップについて、具体的なコード例とともに解説を行います。
category: 
  - Engineering
tags: 
  - Ruby
date: 2023-07-22 00:01 +0000
---

ソフトウェアの開発には、アイデアの具現化だけでなく、そのアイデアを表現するコードの管理と改良が不可欠です。
コードベースが成長し、新機能が追加されるにつれ、ソフトウェアのメンテナンスはより複雑になります。
その複雑さを制御するために重要な技術がリファクタリングです。
本記事では、コードのリファクタリングの基本的なステップを取り上げ、それぞれのプロセスで何が行われ、なぜそれが重要なのかについて詳しく解説します。
## 目次

1. [はじめに](#はじめに)
2. [モジュールのリファクタリングとは？](#モジュールのリファクタリングとは？)
3. [リファクタリングの手順](#リファクタリングの手順)
    1. [リファクタリングするモジュールを選択する](#リファクタリングするモジュールを選択する)
    2. [モジュールのコードを理解する](#モジュールのコードを理解する)
    3. [コード内の重複部分を特定する](#コード内の重複部分を特定する)
    4. [重複部分をメソッドに抽出する](#重複部分をメソッドに抽出する)
    5. [抽出したメソッドを適切な場所に配置する](#抽出したメソッドを適切な場所に配置する)
    6. [重複している部分を新しく作ったメソッドを呼び出すように置き換える](#重複している部分を新しく作ったメソッドを呼び出すように置き換える)
    7. [コードの動作が変わっていないことを確認する](#コードの動作が変わっていないことを確認する)
4. [テストの追加](#テストの追加)
5. [エラーの解決](#エラーの解決)
6. [結論](#結論)

## はじめに

Rubyのモジュールが複雑になってきたと感じたことはありませんか？綺麗に整えたいけどどうしたら良いかわからないという声が聞こえてきそうですね。
そんなあなたに今日はRubyのモジュールのリファクタリング方法と、そのテストの追加について話していきたいと思います。

## モジュールのリファクタリングとは？

リファクタリングとは、コードの外部から見た振る舞いを保ったまま、内部構造を改善することです。
複雑に絡み合ったモジュールをスッキリとした形にすることで、読みやすく保守しやすいコードになります。

## リファクタリングの手順

### リファクタリングするモジュールを選択する

リファクタリングは時間と労力を必要とする作業なので、どのモジュールを対象にするかは重要な意思決定となります。
対象となるモジュールは、頻繁に変更が加えられるものやバグが発生しやすいものなどが適しています。

### モジュールのコードを理解する

選択したモジュールのコードを一行ずつ見ていき、その行が何をしているのかを理解しましょう。
どの部分がどのような機能を果たしているのか理解することで、後の手順で重複部分を特定しやすくなります。

まずは、対象となるモジュールを特定しましょう。その上で、一部機能を独立させることができるかを考えます。

例えば、以下のようなコードがあったとしましょう。

```ruby
module SampleModule
  def self.method_a
    # do something
  end
  
  def self.method_b
    # do something
  end

  def self.method_c
    # do something
  end
end
```

この中で、method_aとmethod_bが密接に関連していて、method_cがそれらとは独立している場合、以下のようにリファクタリングを行います。

```ruby
module SampleModule
  module SubModule
    def self.method_a
      # do something
    end
  
    def self.method_b
      # do something
    end
  end

  def self.method_c
    # do something
  end
end
```

このように分割することで、それぞれのモジュールが持つ役割が明確になり、読みやすくなることがあります。

## コード内の重複部分を特定する

### 重複コードの特定とは？

重複コードを特定するとは、文字通り同じまたは非常に似たコードが二度以上存在する箇所を見つけ出す作業です。
これは「Don't Repeat Yourself（DRY）」原則に反するため、リファクタリングの目的の一つとなります。

### 重複コードの見つけ方

重複コードを見つけるためには、コードを丁寧に読み通すことが最初の一歩となります。
また、コードの規模が大きい場合やプロジェクトが広範である場合には、ツールを使用することも有効です。
例えば、Rubyでは`flay`や`rubocop`などのツールが重複コードの検出に役立ちます。
リファクタに挑戦する場合は採用しましょう。

### 具体例

具体的な例を用いて説明します。以下に、あるRubyモジュール内に存在する2つのメソッドを示します。

```ruby
module ExampleModule
  def method_one
    user = User.find(params[:id])
    user.update(name: params[:name])
    redirect_to user_path(user)
  end

  def method_two
    user = User.find(params[:id])
    user.update(email: params[:email])
    redirect_to user_path(user)
  end
end
```

この例では、`method_one`と`method_two`内でユーザの検索とリダイレクトが重複して行われています。
この部分は抽出して新しいメソッドにまとめることができます。
これにより、重複を排除し、コードの可読性と保守性を高めることができます。

次のステップは、この重複部分をメソッドに抽出することです。このプロセスについては次のセクションで詳しく説明します。

## 重複部分をメソッドに抽出する

### メソッド抽出とは？

メソッド抽出は、重複するコード片を一つのメソッドにまとめるリファクタリング手法の一つです。
これにより、コードの重複が減少し、保守性と可読性が向上します。
また、新しく作成したメソッドに適切な名前をつけることで、そのメソッドが何を行っているのかが明確になり、コードの意図を理解しやすくなります。

### メソッド抽出のプロセス

メソッド抽出の一般的な手順は次の通りです：

1. 重複するコードを特定します。
2. 重複するコード全体を新しいメソッドに移動します。
3. 新しいメソッドに適切な名前を付けます。この名前はメソッドの機能を明確に示すものであるべきです。
4. 元の場所にあった重複コードを新しく作成したメソッドの呼び出しに置き換えます。

### 具体例

先程のユーザの検索とリダイレクトの重複部分をメソッドに抽出してみましょう。

```ruby
module ExampleModule
  def method_one
    user = find_user
    user.update(name: params[:name])
    redirect_to_user(user)
  end

  def method_two
    user = find_user
    user.update(email: params[:email])
    redirect_to_user(user)
  end

  private

  def find_user
    User.find(params[:id])
  end

  def redirect_to_user(user)
    redirect_to user_path(user)
  end
end
```

ここでは、重複していたユーザの検索とリダイレクト部分をそれぞれ`find_user`と`redirect_to_user`という新しいメソッドに抽出しました。
これによりコードの重複が減少し、各メソッドが何を行っているかが一目瞭然になりました。

## 抽出したメソッドを適切な場所に配置する

### メソッドの配置とは？

メソッドの配置とは、そのメソッドが所属すべきモジュールやクラスを見つけ、それをそこに配置することを指します。
一般的に、メソッドはその機能や役割に基づいて適切なモジュールやクラスに配置されます。
この配置は、コードの可読性、再利用性、保守性に大きく影響します。

### メソッドの適切な場所を判断する方法

メソッドをどこに配置するかを決める際に考慮すべきいくつかの要素があります：

1. **関連性**：そのメソッドが直接関連しているオブジェクトや機能は何ですか？ それは特定のモデル、ビュー、コントローラー、またはヘルパーに直接関連していますか？
関連性を考慮することで、それぞれの部分がどのように関連しているかを理解するのが容易になります。

2. **再利用性**：そのメソッドは他の場所でも再利用可能ですか？それが再利用可能である場合、それは可能な限り汎用的なモジュールやクラスに配置するべきです。

3. **シングルレスポンシビリティ**：シングルレスポンシビリティの原則に従って、メソッドは1つの機能のみを持つべきです。これはメソッドを適切な場所に配置するのにも役立ちます。

### 具体例

先ほどの例で`find_user`と`redirect_to_user`メソッドを抽出しましたが、
これらは`ExampleModule`内で再利用される可能性が高いため、そのまま`ExampleModule`に配置されています。
それぞれのメソッドは一つの役割のみを果たしています：ユーザの検索とユーザへのリダイレクト。

しかし、もし`find_user`メソッドが他のモジュールでも使用されるとすると、
そのメソッドを更に汎用的な場所、例えば`UserHelper`といったモジュールに配置することを考えることができます。
これにより、そのメソッドを必要とするどのモジュールからでも簡単にアクセスできるようになります。

```ruby
module UserHelper
  def find_user
    User.find(params[:id])
  end
end

module ExampleModule
  include UserHelper

  def method_one
    user = find_user
    user.update(name: params[:name])
    redirect_to_user(user)
  end

  def method_two
    user = find_user
    user.update(email: params[:email])
    redirect_to_user(user)
  end

  private

  def redirect_to_user(user)
    redirect_to user_path(user)
  end
end
```

上記の例では、`find_user`メソッドは`UserHelper`という更に汎用的なモジュールに移動し、
`ExampleModule`は`UserHelper`をインクルードすることで`find_user`メソッドを利用しています。
このように配置を適切に行うことで、コードの可読性と再利用性が向上します。

## 重複している部分を新しく作ったメソッドを呼び出すように置き換える

### メソッド呼び出しの置き換えとは？

この手順は、元のコード内の重複部分を新しく作成したメソッドの呼び出しに置き換えることを指します。
つまり、以前同じ機能を達成するために何度も繰り返していたコードブロックを、新しく定義したメソッドの一つの呼び出しに置き換えます。

### メソッド呼び出しの置き換えのメリット

1. **コードの可読性**：コード内で同じ処理が何度も書かれていると、その処理が何をするのか理解するのが難しくなります。
一方、その処理をメソッドとして抽出し、メソッド名をつけることで、一見してその処理が何をするものかが分かりやすくなります。

2. **保守性の向上**：重複部分がメソッドに置き換えられると、その処理の修正や機能追加が必要になった場合、メソッドの定義部分だけを修正すれば良くなります。これにより、保守性が向上します。

3. **バグの発生リスクの減少**：重複部分があると、それぞれを修正する際に一部を見落とすというミスが発生しやすくなります。
そのようなミスからくるバグの発生リスクを減らすためにも、重複部分を一つのメソッドにまとめることが推奨されます。

### 具体例

先ほど作成した`ExampleModule`で`find_user`と`redirect_to_user`メソッドを作りました。
そして、それぞれのメソッドが`method_one`と`method_two`で呼び出され、それぞれが必要とする処理を実行しています。

```ruby
module UserHelper
  def find_user
    User.find(params[:id])
  end
end

module ExampleModule
  include UserHelper

  def method_one
    user = find_user
    user.update(name: params[:name])
    redirect_to_user(user)
  end

  def method_two
    user = find_user
    user.update(email: params[:email])
    redirect_to_user(user)
  end

  private

  def redirect_to_user(user)
    redirect_to user_path(user)
  end
end
```

新しく作成したメソッドを使用して重複部分を置き換えることにより、コードが簡潔になり、可読性が向上し、保守性が向上します。

## コードの動作が変わっていないことを確認する

### リファクタリング後の動作確認とは？

リファクタリングは、プログラムの外部的な振る舞いを変えずに、内部のコードを改善することを目指します。
しかし、リファクタリングの過程で何らかの間違いがあった場合、コードの動作自体が変わってしまう可能性があります。
したがって、リファクタリング後には、コードの動作が変わっていないことを必ず確認する必要があります。

### 動作確認の手段

動作確認には以下のような方法があります。

1. **単体テスト/統合テスト**：コードの振る舞いを自動的に確認するためにテストを用います。
テストフレームワークを使って、コードが期待通りの振る舞いをするか自動的にチェックします。
リファクタリング前後でテスト結果が変わらなければ、コードの振る舞いは変わっていないと言えます。

2. **手動での動作確認**：ユーザーと同じようにアプリケーションを操作して、コードの振る舞いを手動で確認します。
ただし、この方法は手間がかかり、見落としも発生しやすいです。

## テストの追加


リファクタリングを行った後は、必ずテストを行いましょう。テストを行うことで、リファクタリングがコードの振る舞いを変えてしまっていないことを確認できます。
テストはコードの品質を保つための重要な工程であり、リファクタリングが予期せぬ問題を引き起こしていないことを確認する手段です。


### 具体例

例えば、Ruby on Railsを使用している場合、テストフレームワークとしてRSpecを用いることが多いです。
以下に、リファクタリング前後で動作が変わらないことを確認するためのテストコードの一例を示します。

```ruby
# テストコード
require 'rails_helper'

RSpec.describe ExampleModule, type: :model do
  describe '#method_one' do
    let(:user) { create(:user) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:params).and_return(id: user.id, name: 'New Name')
    end

    it 'updates user name and redirects to user page' do
      expect(user.name).not_to eq 'New Name'
      ExampleModule.new.method_one
      expect(user.reload.name).to eq 'New Name'
    end
  end
end
```

上記のテストコードは、`ExampleModule`の`method_one`メソッドがユーザーの名前を更新し、そのユーザーのページにリダイレクトすることを確認しています。
リファクタリング前後でこのテストが成功すれば、`method_one`の動作は変わっていないと確認できます。

一般的に、動作確認はリファクタリングの各ステップ後、また全体のリファクタリングが完了した後にも行うべきです。

## エラーの解決

リファクタリングやテスト作成中に発生する可能性のあるいくつかのエラーについて説明します。

1. **クラスやモジュールが見つからない**：これはクラスやモジュールが定義されているファイルが適切に`require`または`require_relative`で読み込まれていないことが原因です。

2. **Gemが見つからない**：これは必要なGemがインストールされていないか、正しく読み込まれていないことが原因です。`bundle install`コマンドを使用してGemをインストールし、`require`を使用して適切に読み込むことが重要です。

3. **メソッドが見つからない**：これはメソッドが定義されているクラスやモジュールが適切に読み込まれていないか、メソッド名が間違っている可能性があります。

各エラーに対する詳細な解決策を提供し、リファクタリングとテスト作成の過程を円滑に進めるためのガイダンスを提供します。
## 結論

今回は、Rubyのモジュールのリファクタリングとそのテストの追加についてお話ししました。
複雑なモジュールを整理し、読みやすいコードにすることで、将来的なバグの予防や機能追加のスムーズさにつながります。
そしてテストはその変更が想定通りであることを保証する大切な役割を果たします。今回学んだことを是非活用して、DRYでより良いコードを書きましょう！