---
layout: post
title: The Frameworks of Effective Product Design Sense
subtitle: Craft products better with better systematic design judgment
description: 
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
image: "/assets/images/newbusinessflowchart/pro.png)"
category:
- Engineering
tags:
- Software
- Ruby
---


久しぶりにRubyを使用して開発を行うので
段階的に振り返って見た

## セクション1: 基礎文法と構文

目標: Rubyの基本的な文法と構文を理解する。

変数、データ型（数値、文字列、配列、ハッシュ）
条件分岐（if、unless、case）
ループ（while、for、each）
メソッド定義と呼び出し
オブジェクト指向の基礎（クラス、インスタンス、メソッド）

セクション1「基礎文法と構文」から始めましょう。まず、基本的なRubyの文法と構文を少しずつ確認しながら学んでいきます。進捗に応じて確認問題も用意します。

### 1. 変数とデータ型

#### 変数

Rubyでは変数に値を代入するとき、型を明示する必要はありません。Rubyが自動的に適切なデータ型を判断します。

```ruby
name = "Taro"   # 文字列
age = 25        # 数値
height = 1.75   # 浮動小数点数
is_student = true  # 真偽値
```

#### データ型

主なデータ型には以下があります：

- 数値（Integer, Float）
- 文字列（String）
- 配列（Array）
- ハッシュ（Hash）
- 真偽値（Boolean）

```ruby
numbers = [1, 2, 3, 4, 5]  # 配列
person = {name: "Taro", age: 25, height: 1.75}  # ハッシュ
```

配列とハッシュは、どちらも複数のデータを一つの変数に格納するためのデータ構造ですが、それぞれ異なる使い方や目的があります。ここで、配列とハッシュの違いを詳しく見ていきましょう。

##### 配列 (Array)

- **順序付きのデータの集合**を扱います。
- 各要素にはインデックス番号（0から始まる数値）でアクセスします。
- 同じデータ型の値だけでなく、異なるデータ型の値も格納できます。

#### 配列の特徴

- **順番が重要な場合**に使います。
- 各要素にアクセスする際は、インデックス番号（0, 1, 2, …）を使います。

#### 配列の例

```ruby
# 配列の作成
fruits = ["apple", "banana", "cherry"]

# 要素にアクセス（インデックス番号を使用）
puts fruits[0]  # apple
puts fruits[1]  # banana

# 配列に新しい要素を追加
fruits << "orange"
puts fruits[3]  # orange

# 配列の長さを取得
puts fruits.length  # 4
```

### ハッシュ (Hash)

- **キーと値のペア**を扱います。
- インデックス番号の代わりに、任意のキーを使って各要素にアクセスします。
- 配列と同様に異なるデータ型の値を格納できますが、各要素にキーが関連付けられているため、**順序は重要ではない**ことが多いです。

#### ハッシュの特徴

- **名前付きのデータ**を扱う場合に便利です（例: 名前と年齢など）。
- **キーを使ってアクセス**するため、順番よりもキーで値を取り出すことが重要です。

#### ハッシュの例

```ruby
# ハッシュの作成
person = {name: "Taro", age: 25, height: 1.75}

# 値にアクセス（キーを使用）
puts person[:name]   # Taro
puts person[:age]    # 25

# ハッシュに新しいペアを追加
person[:weight] = 68
puts person[:weight]  # 68

# 全てのキーと値を表示
person.each do |key, value|
  puts "#{key}: #{value}"
end
# 出力:
# name: Taro
# age: 25
# height: 1.75
# weight: 68
```

### 配列とハッシュの違い

| 項目           | 配列 (Array)                      | ハッシュ (Hash)                   |
|----------------|-----------------------------------|------------------------------------|
| **アクセス方法**| インデックス（0, 1, 2, ...）でアクセス | キー（シンボルや文字列など）でアクセス |
| **順序**       | 順序が重要                        | 順序はあまり重要ではない            |
| **使用目的**   | データに順序がある場合に便利        | 名前付きのデータを管理する場合に便利 |
| **例**         | ["apple", "banana", "cherry"]     | {name: "Taro", age: 25, height: 1.75} |

### どちらを使うかの選び方

- **順序が大切で、番号でデータにアクセスする場合** → 配列を使う。
- **データに名前があり、それに基づいてアクセスする場合** → ハッシュを使う。

例えば、クラスに生徒のリストがあり、全員の名前を順番に格納したい場合は「配列」が便利です。一方、各生徒の名前とその成績を一緒に管理したい場合は「ハッシュ」が適しています。


### 2. 条件分岐

#### if文

条件が真の場合に実行される処理です。

```ruby
age = 18

if age >= 20
  puts "You are an adult."
else
  puts "You are not an adult."
end
```

#### unless文

if文の逆で、条件が偽の場合に実行されます。

```ruby
is_student = false

unless is_student
  puts "You are not a student."
end
```

#### case文
複数の条件を評価する場合に便利です。

```ruby
grade = "B"

case grade
when "A"
  puts "Excellent"
when "B"
  puts "Good"
when "C"
  puts "Average"
else
  puts "Poor"
end
```

### 3. ループ

#### whileループ

条件が真の間、処理を繰り返します。

```ruby
i = 1

while i <= 5
  puts i
  i += 1
end
```

#### eachループ

配列やハッシュを使って、各要素をループします。

```ruby
numbers = [1, 2, 3, 4, 5]

numbers.each do |number|
  puts number
end
```

### 4. メソッド定義

Rubyでは、メソッドを定義して処理をまとめることができます。

```ruby
def greet(name)
  puts "Hello, #{name}!"
end

greet("Taro")  # Hello, Taro!
```

### 確認問題

1. 名前を入力するとその名前と挨拶を表示するメソッドを作ってください。

2. 数字の配列を用意して、全ての数字の合計を計算するeachループを作成してください。
3. FizzBuzzプログラムを作成してください（1から100までの数字を表示し、3の倍数の時は"Fizz"、5の倍数の時は"Buzz"、両方の倍数の時は"FizzBuzz"と表示する）。

```ruby
#1
def hello_user(name)
  puts "Hello, #{name}!"
end

# メソッドを呼び出す
hello_user("Taro")  # Hello, Taro!

#2
def sum_number
  numbers = [1,2,3,4,5,6,7,8,9,10]
  total = 0

  numbers.each do |number|
    total += number
  end

  puts total  # 合計を表示
end

sum_number  # 出力: 55


#3
def fizzbuzz
  (1..100).each do |num|
    if num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    else
      puts num
    end
  end   
end

fizzbuzz  # FizzBuzzプログラムを実行
```
