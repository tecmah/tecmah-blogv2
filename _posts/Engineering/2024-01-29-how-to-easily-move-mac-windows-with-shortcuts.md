---
layout: post
title: How To Easily Move Mac Windows With Shortcuts
subtitle: Craft products better with better systematic design judgment
banner:
  image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/888c0f7d-d7a4-4367-b728-6c66f182a5ad
  opacity: 0.3
category:
- Engineering
tags:
- Software
- Useful Tools
- window management app
date: '2024-01-29'
---
- [はじめに](#はじめに)
- [アプリケーションの紹介](#アプリケーションの紹介)
  - [有料のアプリケーションで解決する方法](#有料のアプリケーションで解決する方法)
    - [Magnetの紹介](#magnetの紹介)
    - [BetterSnapTool](#bettersnaptool)
  - [無料のアプリケーションで解決する方法](#無料のアプリケーションで解決する方法)
    - [Rectangleの紹介](#rectangleの紹介)
    - [Spectacleの紹介](#spectacleの紹介)
- [AppleScriptの使用](#applescriptの使用)
- [まとめ](#まとめ)

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

有料アプリケーションではMagnetが有名です。

日本語にも対応していてサブスクではなく買い切りのアプリケーションの為自分はMagnetを採用しています。

#### BetterSnapTool

### 無料のアプリケーションで解決する方法

---

### Rectangleの紹介





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
