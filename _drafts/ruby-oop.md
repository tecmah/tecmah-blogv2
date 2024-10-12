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


このセクションでは、Rubyのオブジェクト指向プログラミング（OOP）を理解し、実際にクラスやオブジェクトを使ったプログラムを書いていきます。

### セクション2: オブジェクト指向プログラミング

Rubyはオブジェクト指向言語であり、クラスとオブジェクトを中心に設計されています。以下の概念を学んでいきます。

### 1. クラスとインスタンス

- **クラス**: オブジェクトの設計図。オブジェクトの属性や動作（メソッド）を定義します。
- **インスタンス**: クラスから作られる具体的なオブジェクト。

#### クラスの定義

Rubyでクラスを定義する方法は以下の通りです。

```ruby
class Person
  # インスタンス変数とメソッドを定義
  def initialize(name, age)
    @name = name   # @name はインスタンス変数
    @age = age     # @age はインスタンス変数
  end

  # インスタンスメソッドの定義
  def greet
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

# インスタンスの作成
person1 = Person.new("Taro", 25)
person1.greet  # Hello, my name is Taro and I am 25 years old.
```

### 2. アクセサメソッド（getter/setter）

Rubyでは、クラス内の変数に直接アクセスすることができません。アクセスするためのメソッド（getter）と値を設定するためのメソッド（setter）を定義する必要があります。これを簡略化するために `attr_accessor` を使います。

```ruby
class Person
  attr_accessor :name, :age  # nameとageのgetter/setterメソッドを自動生成

  def initialize(name, age)
    @name = name
    @age = age
  end
end

person = Person.new("Hanako", 22)
puts person.name   # Hanako
person.age = 23    # 年齢を23に更新
puts person.age    # 23
```

### 3. 継承とモジュール

クラスは他のクラスを**継承**することができます。これにより、親クラスの機能を子クラスに引き継ぐことができます。

#### 継承の例

```ruby
# 親クラス
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts "#{@name} makes a sound."
  end
end

# 子クラス
class Dog < Animal
  def speak
    puts "#{@name} barks."
  end
end

dog = Dog.new("Pochi")
dog.speak  # Pochi barks.
```

### 4. モジュール

モジュールはクラスの中に取り込むことができる機能です。コードを再利用するための手段として使われます。

```ruby
module Swimmable
  def swim
    puts "I can swim!"
  end
end

class Dog
  include Swimmable
end

dog = Dog.new
dog.swim  # I can swim!
```

### 確認問題

1. `Person` クラスを作成し、名前と年齢を持つオブジェクトを生成してみてください。オブジェクトの名前を表示するメソッドを作ってください。
2. `Animal` クラスを作り、それを継承した `Cat` クラスを作成し、それぞれに `speak` メソッドを実装してください。
3. モジュールを作成し、`jump` メソッドを含めてください。このモジュールを使ったクラスを作成し、そのクラスに `jump` 機能を追加してください。


```Ruby
#1
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def show_name
    puts "My name is #{@name}."
  end
end

person = Person.new("Taro", 25)
person.show_name  # My name is Taro.

#2
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts "#{@name} makes a sound."
  end
end

class Cat < Animal
  def speak
    puts "#{@name} meows."
  end
end

cat = Cat.new("Whiskers")
cat.speak  # Whiskers meows.


#3
module Jumping
  def jump
    puts "I can jump!"
  end
end

class Pig < Animal
  include Jumping
end

pig = Pig.new("Porky")
pig.jump  # I can jump!
```