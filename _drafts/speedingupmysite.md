---
layout: post
title: Speeding up MySite
subtitle: Craft products better with better systematic design judgment
banner:
  image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/378bb28c-0f74-4f83-8bfd-1774beb11852
  opacity: 0.3
category: 
  - Engineering
tags: 
  - Software Engineering
  - blog
  - 
---

## はじめに

blogに記事を書いていて、blogをもっと快適に使いたいなという欲が出てきました。
[PageSpeed Insights](https://pagespeed.web.dev/analysis/https-www-tecmah-com/qa3nmvh66l?form_factor=desktop)で測ってみたら
なんとパフォーマンスがオレンジや赤ばかりになっています。
![image-1](https://cdn.discordapp.com/attachments/1198133923855732756/1199069514273407146/2024-01-23_2.52.59.webp?ex=65c13381&is=65aebe81&hm=9b8d1012d09a2e2c866e772688c534916e9e06f6fdd614a8a001d379ab098d0d&)

**すっごい気持ち悪い**

これを一つづつ改善していこうと思います。

## 画像をwebpに変換する

今まで画像をblogにあげてきましたが、高速化された最適な形式を考えてはいませんでした。
せいぜいが画像をURLで挿入することを考える程度です。

webpへの変換は以下のサイトを使います

[squoosh](https://squoosh.app/)

スクリーンショットを自動で変換して自動でCDNにアップロードして管理できればいいな
という構想はありますが、それをやると時間がかかってしまうので別のタイミングで行おうと思います。

変換をかける画像は以下のような画像です。
bannerやfaviconをpngで表示されているので修正します。
![image-2](https://cdn.discordapp.com/attachments/1198133923855732756/1199071931039760424/2024-01-23_4.22.42.webp?ex=65c135c2&is=65aec0c2&hm=d5ed808bf7fb805c3862936128a10d85f6e6fc8982d805d5cb501c62d1c01517&)

### webpに変換した結果

Webpに変換した結果パフォーマンスの値が**1**改善しました。
わぁ・・・・たった1かぁ

![image-3](https://cdn.discordapp.com/attachments/1198133923855732756/1199077866344808468/2024-01-23_4.45.51.webp?ex=65c13b49&is=65aec649&hm=f0937b976198239ed5228c2e3b926d5964854dba31d468e45d8a5ddca89d5eef&)

というかCDNで表示している画像がレンダリング遅いっておこられてますね。
リポジトリ内であまり画像は管理したくなかったですが
faviconとbannerはwebpに変換して例外にします。

全部CDN経由で画像管理しようと思ってたけどそんなに遅いのか。

### よく扱う画像のCDN経由をやめた結果

![image-4](https://cdn.discordapp.com/attachments/1198133923855732756/1199081350624456817/2024-01-23_4.59.52.webp?ex=65c13e87&is=65aec987&hm=80f9d79fbfb14122d43640c843d942c2edea4108f0d3d831b2e01780bd5e04ce&)

かなり改善されました。
次はどう100に近づけるかというところですが、今回はここまでにしておきます。

おまけ

### Macで自動的にスクリーンショットをとる場合にwebpに変換する

参考：<https://ikumengineer.net/auto-screenshot-to-webp-mac/>
