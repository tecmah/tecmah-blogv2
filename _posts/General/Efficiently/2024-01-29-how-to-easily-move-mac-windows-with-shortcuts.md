---
layout: post
title: How To Easily Move Mac Windows With Shortcuts
subtitle: Increasing Mac Productivity　"Window Management Apps and Shortcuts"
description: "On Windows operating systems, shortcuts such as **win + →*** allow you to to adjust the size of the active window from the beginning. On the Mac, this shortcut is not available and has been a problem for many years.By using the application introduced below, customize keyboard shortcuts to easily move and resize windows. These applications offer a variety of useful functions, such as snapping a window to a specific part of the screen or resizing it to a specific size."
banner:
  image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/888c0f7d-d7a4-4367-b728-6c66f182a5ad
  opacity: 0.3
image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/888c0f7d-d7a4-4367-b728-6c66f182a5ad
category:
  - General
tags:
  - Efficiently
date: '2024-01-29'
---

## はじめに

WindowsのOSでは**win + →**等のショートカットで

初期からアクティブなウインドウをサイズ調整できます。

Macの場合はこのショートカットがなくて長年悩まされてきました。

以下のの紹介するアプリケーションを使用することで、

キーボードショートカットをカスタマイズし、ウィンドウの移動やサイズ変更を簡単に行うことができます。

これらのアプリは、ウィンドウを画面の特定の部分にスナップさせる、特定のサイズに変更するなど、様々な便利な機能を提供します。

## アプリケーションの紹介

---

このウインドウを適切に一瞬で移動させる為の解決方法は

有料か無料のアプリケーションをいれて自分の使いやすいショートカットに登録するというものです。

### 有料のアプリケーションで解決する方法

---

#### Magnetの紹介

![magnet](https://is1-ssl.mzstatic.com/image/thumb/PurpleSource112/v4/54/cf/a1/54cfa113-85ec-0bb7-29d5-c314a183a7b8/6d503693-fe36-40bd-b374-3afaf1bd8aac_MGNT_store_2_8_0_GM_01_JP.png/313x0w.webp)

有料アプリケーションでは[Magnet](https://apps.apple.com/jp/app/magnet-%E3%83%9E%E3%82%B0%E3%83%8D%E3%83%83%E3%83%88/id441258766?mt=12)が有名です。

日本語にも対応していてサブスクではなく買い切りのアプリケーションの為自分はMagnetを採用しています。

#### BetterSnapToolの紹介

正直こちらは使ってはいないのでわかりませんが、Magnetより安いのが魅力です。

付属するアプリケーションが画面の移動以外もサポートをしている為、高機能で選ぶ人が多い印象です。

![BetterSnapTool](https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/4b/b9/fa/4bb9fa79-bf61-c591-e4c0-d4b93408b332/pr_source.jpg/313x0w.webp)

[BetterSnapToolへのリンク](https://apps.apple.com/jp/app/bettersnaptool/id417375580?mt=12)

### 無料のアプリケーションで解決する方法

---

### Rectangleの紹介

RectangleはSpectacleをベースにSwiftで書かれたウィンドウ管理アプリです。

かなり高機能で無料で使えるため、私もMagnetを買わなくてよかったかもしれないと思うほどです。

Swiftの勉強にもなるので、ぜひ使ってみてOSSに貢献してみてください。

気に入れば**Rectangle Pro**にも有料でアップグレードできます。

<p><a href="https://rectangleapp.com?wvideo=ujke3wuva9"><img src="https://embed-ssl.wistia.com/deliveries/2a6e684731e1b623f5d6926dabce9125.jpg?image_play_button_size=2x&amp;image_crop_resized=960x540&amp;image_play_button=1&amp;image_play_button_color=174bd2e0" width="400" height="225" style="width: 400px; height: 225px;"></a></p><p><a href="https://rectangleapp.com?wvideo=ujke3wuva9">Rectangle Mac</a></p>

[Rectangleのリポジトリへのリンクはこちら](https://github.com/rxhanson/Rectangle)

[RectangleのHPへのリンクはこちら](https://rectangleapp.com/)


つい最近のアプリケーションのサポートが終わってしまいましたが、

無料では**Spectacle**というアプリケーションがgithubで公開されていました。

このRctangleが紹介できたのは、SpectacleのREADME.mdで紹介をしてくれたおかげです。

#### Spectacleの紹介

素晴らしいOSSだったSpectacleは

Jan 22, 2023にリポジトリはパブリックアーカイブされてしまいました。

[Githubでアーカイブされたリポジトリへのリンクはこちら](https://github.com/eczarny/spectacle)



また自分でSpectacleをforkして触れるような方であれば**AppleScript**でも解決は可能です。

### AppleScriptの使用

MacにはAutomatorやAppleScriptといった強力なツールが内蔵されており、これらを使用してウィンドウを移動するためのショートカットを作成することができます。

これは少し高度な方法ですが、カスタムスクリプトを作成して特定のキー操作でウィンドウを移動させることが可能です。

正直に言うと私は面倒なのであまり推奨できない方法ですが、以下のようなスクリプトになります。

```:AppleScript
tell application "System Events"
    set frontAppName to name of first application process whose frontmost is true
    tell process frontAppName
        set frontWindow to window 1
        set {windowX, windowY, windowWidth, windowHeight} to bounds of frontWindow
        set screenWidth to do shell script "defaults read /Library/Preferences/com.apple.windowserver DisplayResolutionWidth"
        set screenHeight to do shell script "defaults read /Library/Preferences/com.apple.windowserver DisplayResolutionHeight"
        set newWidth to screenWidth / 2
        set newHeight to screenHeight
        set newBounds to {newWidth, windowY, screenWidth, windowHeight}
        set bounds of frontWindow to newBounds
    end tell
end tell

```

このスクリプトにキーボードイベントを追加するか、何かしらのプログラマブルキーボードから

スクリプトを実行することにより可能になるとおもいます。

### まとめ

まずMacを購入してインストールするアプリケーションは、このような少しでも操作を便利にするアプリケーションを入れることが多いはずです。

この記事を読んだ人がが効率よく作業に打ち込むために有益となりますのでぜひ活用してください。
