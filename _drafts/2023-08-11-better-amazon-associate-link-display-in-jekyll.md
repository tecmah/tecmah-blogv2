---
layout: post
title: Jekyllでamazonのアソシエイトリンク表示をマシにする
date: 2023-08-11 12:56 +0900
description: 
category: Engineering
tags: Software Amazon Affiliate
---

注意：この記事は少し感情表現が多めになっています。
amazonのアソシエイトリンクの表示が汚くて大変困る


1. [kindleアソシエイトリンクを横に](#kindleアソシエイトリンクを横に)
2. [kindleアソシエイトの元の表示](#preparation)
3. [aaaaa](#visuals)
4. [aaaaa](#code-explanation)
5. [aaaa](#delivery)
6. [aaa](#qna)
7. [aaaa](#conclusion)



## kindleアソシエイトリンクを横に

マークダウンで記事を記入する際に、画像とリンクを伴うアソシエイトリンクを入れると
縦に積み重なるようになりスクロールが多くなるし、見づらくなる。

横に表示することによって、見やすく選びやすくなった。

![Alt text](/assets/images/2023-08-11-better-amazon-associate-link-display-in-jekyll/image-1.png)

これはAmazonリンクに対して以下のようなコードの変更で横に連続して表示が可能になる。

```html
style="display:inline-block; width:120px;height:240px;"

```

`display:inline-block;`の部分を追加する。
width:120px;height:240px;の部分は初期で固定されている。



![Alt text](/assets/images/2023-08-11-better-amazon-associate-link-display-in-jekyll/image.png)

