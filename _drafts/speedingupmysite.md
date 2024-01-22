---
layout: post
title: Speeding up MySite
subtitle: Craft products better with better systematic design judgment
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
category: Engineering/General/Philosophy/History/Social Sciences/Natural Sciences/Applied
  Sciences/Arts/Sports/HealthAndMedicine/LanguageAndLiterature/CultureAndEducation/GeographyHistoryAndBiography/Kindle/BusinessAndManagement
tags: Hardware/Software/Network/Security/Software Engineering/InformationSystems/ArtificialIntelligence/TheoryOfComputation/Human-ComputerInteraction
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



## Macで自動的にスクリーンショットをとる場合にwebpに変換する

参考：<https://ikumengineer.net/auto-screenshot-to-webp-mac/>


