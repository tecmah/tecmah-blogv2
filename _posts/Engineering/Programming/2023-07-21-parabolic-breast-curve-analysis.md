---
layout: post
title: おっぱいの形の放物線を作ってみた：物理学とコンピュータ・プログラミングの出会い
banner:
  image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/465604f4-17ed-4369-a7af-fd9e797bcd1d
  opacity: 0.3
categories:
  - Engineering
tags:
  - Programming
date: 2023-07-16 23:03:24 +0900
---

こんにちは、yonoriです。今日はちょっと独特な研究を行いました。なんと「おっぱいの形の放物線」を作ってみることにチャレンジしたのです！
ここでは、私がどのようにしてその形状をプログラミング言語で描画し、それがどのような物理学の概念とつながるかを紹介します。
もちろん、この記事は微妙なテーマを扱っていますが、不快感を与えないよう、敬意を持って情報を提供します。では、始めましょう。

## 物理学の視点から考える

物理学の視点からおっぱいを考えると、おっぱいは基本的に流体力学と力学の原則に従います。

1.力学的特性：おっぱいは基本的には流体（脂肪組織）と固体（腺組織、筋肉）の複合体であり、その形状は重力、筋肉の力、ブラジャーなどの外部支持によって決定されます。
特に立っているときや動いているときは、おっぱいの形状や動きは重力と筋肉の力のバランスによって大きく影響を受けます。

2.流体力学：おっぱいの主要な成分である脂肪は、流体の性質を示します。これは、例えば、走ったりジャンプしたりしたときのおっぱいの揺れ方に現れます。
この揺れは、おっぱいの大きさ、形状、そして固定の仕方によって異なります。

3.振動と波動：運動中のおっぱいは振動を示すことがあります。これは、例えば、ジョギング中に見られるおっぱいの上下運動です。
これは、おっぱいの質量、弾性性、そして固定の仕方によって異なる振動パターンを生み出します。

4.熱力学とエネルギー転送：おっぱいは体温を保つために重要な役割を果たします。また、授乳中はカロリーを消費して乳を生産し、熱を発生します。このエネルギー転送と熱の発生・放出は、熱力学の原則に従います。

私の力では全てを表現することは難しいでしょうが、放物線で表現するところから始めましょう。

### 何故放物線なのか？

まずは、なぜおっぱいの形が放物線で近似できると考えたのか説明します。これは物理学の基本的な法則に由来します。
自然界の物体は、エネルギーを最小化することで形成される傾向があります。この原理は、物理学の「最小作用原理」に基づいています。

乳房の形は、重力の影響により決まります。ここでの重要なポイントは、重力が垂直方向に働くため、乳房が受ける力は均一ではないということです。
その結果、乳房の形は、力の影響を最小化する形状、つまり放物線になります。

## プログラミングで放物線を描画する

では、この放物線をどのようにプログラムで描画するのでしょうか。ここでは、RubyとPythonを用いて、その方法を紹介します。

### Rubyによる実装

Rubyを使用した放物線の描画は以下のようになります：

```ruby
require 'gnuplot'

# Define the breast shape using an ellipse, but only the upper half
x_breast = Array.new(100) {|i| -2.5 + i * 0.05}
y_breast = x_breast.map {|x| Math.sqrt(6.25 - x**2)}  # Using 6.25 (2.5^2) to make the breast rounder
x_breast2 = x_breast.map {|x| x + 5}  # For the second breast

# Define the nipple shape using a smaller circle, but only the upper half
x_nipple = Array.new(100) {|i| -0.3 + i * 0.006}
y_nipple = x_nipple.map {|x| Math.sqrt(0.3**2 - x**2) + 2.5}  # Move it to y=2.5
x_nipple2 = x_nipple.map {|x| x + 5}  # For the second nipple

Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.title  "Breast Curve"
    plot.xlabel "x"
    plot.ylabel "y"
    plot.data << Gnuplot::DataSet.new([x_breast, y_breast]) do |ds|
      ds.with = "lines"
      ds.linewidth = 2
    end
    plot.data << Gnuplot::DataSet.new([x_breast2, y_breast]) do |ds|
      ds.with = "lines"
      ds.linewidth = 2
    end
    plot.data << Gnuplot::DataSet.new([x_nipple, y_nipple]) do |ds|
      ds.with = "lines"
      ds.linewidth = 2
    end
    plot.data << Gnuplot::DataSet.new([x_nipple2, y_nipple]) do |ds|
      ds.with = "lines"
      ds.linewidth = 2
    end
  end
end

```

ここで利用しているのは`gnuplot`というライブラリで、Rubyで簡単にグラフをプロットすることができます。

### Pythonによる実装

Pythonでも同様の処理を行い、放物線を描画します：

```python
import matplotlib.pyplot as plt
import numpy as np

# Define the breast shape using an ellipse, but only the upper half
x_breast = np.linspace(-2.5, 2.5, 100)
y_breast = np.sqrt(6.25 - x_breast**2)  # Using 6.25 (2.5^2) to make the breast rounder
x_breast2 = x_breast + 5  # For the second breast

# Define the nipple shape using a smaller circle, but only the upper half
x_nipple = np.linspace(-0.3, 0.3, 100)  # Smaller nipple
y_nipple = np.sqrt(0.3**2 - x_nipple**2) + 2.5  # Move it to y=2.5
x_nipple2 = x_nipple + 5  # For the second nipple
y_nipple2 = y_nipple  # The same for the second nipple

# Plotting
plt.figure(figsize=(10, 6))
plt.title("Breast Curve")
plt.xlabel("x")
plt.ylabel("y")

# Plotting the first breast and its nipple
plt.plot(x_breast, y_breast, 'b')
plt.fill(x_nipple, y_nipple, 'r')

# Plotting the second breast and its nipple
plt.plot(x_breast2, y_breast, 'b')
plt.fill(x_nipple2, y_nipple2, 'r')

# Saving the figure before showing it
output_path = "/mnt/data/two_breasts_curve_small_nipple.png"
plt.savefig(output_path)

plt.grid(True)
plt.axhline(0, color='black',linewidth=0.5)
plt.axvline(0, color='black',linewidth=0.5)
plt.show()

```

Pythonでは`matplotlib`と`numpy`を利用して、放物線のプロットを行っています。


![two_breasts_curve_small_nipple](https://github.com/tecmah/tecmah-blogv2/assets/11237144/2109d18c-551c-4d29-ac38-ec9cb24adb62)

## まとめ：放物線の魅力と物理学の原理

おっぱいの形の放物線を作ってみましたが、いかがだったでしょうか？このように日常生活の身近な事象でも、物理学の原理が隠れていることがあります。
物理学は、私たちが見ている世界を説明するためのツールであり、その原理を理解することで、世界をより深く理解することができます。

今回の記事は、少しユニークなトピックでしたが、物理学とプログラミングの魅力を感じていただければ幸いです。
そして、放物線はただの数学的な形状でなく、私たちの身体や自然界にも存在することをお伝えすることができたと思います。


## 世の中にHENTAIの天才は既にいる

この記事を書いた後にgoogleで検索をしてみたところ
すごいのがありました
しかも動く・・・・

![Alt text](https://github.com/tecmah/tecmah-blogv2/assets/11237144/40750872-b3d5-4745-937d-5ba8768f175c)

[リンク](https://www.desmos.com/calculator/i05puaquwh?lang=ja)