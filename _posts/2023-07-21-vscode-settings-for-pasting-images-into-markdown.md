---
layout: post
title: VSCodeでクリップボードの画像をそのままMarkdownに貼り付ける方法
date: 2023-07-21 23:40 +0900
description: この記事では、VSCodeの設定を利用してクリップボードの画像をMarkdownに直接貼り付ける方法を詳しく説明します。また、Windowsでのペースト例や、画像圧縮のためのVSCode拡張機能についても触れています。この情報は2023年7月時点のものです
category: Engineering
tags: Software VScode Setting
---

この記事では、VSCodeでクリップボードの画像をそのままMarkdownに貼り付ける方法を詳しく説明します。これは、2023年7月時点の情報です。
公式でいつの間にかクリップボードの画像をMarkdownのファイルに貼り付けることができるようになっていました。
詳しく調べてみると[2023年5月のアップデート](https://code.visualstudio.com/updates/v1_79#_markdowncopyfilesdestination)で正式に採用されたみたいです。


## 目次

1. [VSCodeの設定](#VSCodeの設定)
2. [Macでのペーストの例](#Macでのペーストの例)
3. [設定方法の詳細](#設定方法の詳細)
4. [注意点](#注意点)
5. [画像圧縮を行うには](#画像圧縮を行うには)

## VSCodeの設定

VSCodeに以下の設定を追加することで、クリップボードの画像をそのままMarkdownにペーストできるようになります。
自分は大体assetsフォルダの中にimagesを入れるので`assets/images/`で設定しています。

```json
// settings.json
{
    "markdown.experimental.copyFiles.destination": {
        "**/**/*": "assets/images/"
    },
}
```

jsonで設定しない場合も紹介します
`markdown.copyFiles.destination`で設定することになるので、左下の歯車⚙️マークから設定に飛びます。

その後出てきた検索バーに`markdown.copy`まで打ち込めば出てきます。

項目の追加で
項目`**/**/*`　値`assets/images/`
を入力します。

![Alt text](../../../assets/images/2023-07-21-vscode-settings-for-pasting-images-into-markdown/image.png)
## Macでのペーストの例

Mac上でペーストすると、次のようになります。

```md
![Alt text](assets/images/image.png)
![Alt text](assets/images/image-1.png)
![Alt text](assets/images/image-2.png)
```

画像は自動で `images` フォルダ内に連番で保存されます。スクリーンショット入りのドキュメントを書く際にとても便利な機能です。

## 設定方法の詳細

ドロップまたは貼り付けによって作成されたファイルをコピーするする場所を定義できます。
次の変数を使用できます

```zsh
${documentFileName} — Markdown ドキュメントの完全なファイル名。例: readme.md。
${documentBaseName} — Markdown ドキュメントのベース名。例: readme。
${documentExtName} — Markdown ドキュメントの拡張子 (例: md)。
${documentDirName} — Markdown ドキュメントの親ディレクトリの名前。
${documentWorkspaceFolder} — Markdown ドキュメントのワークスペース フォルダー。
例: /Users/me/myProject。
ファイルがワークスペースに含まれていない場合、これは ${documentDirName} と同じです。
${fileName} — ドロップされたファイルのファイル名。例: image.png。
```

また正規表現も使用できます。
**慣れていない人には難しいかもしれませんのでここで説明しておきます。**

正規表現（Regular Expression）は、文字列のパターンを表現するための強力なツールです。
ディレクトリの場所を表現するために正規表現を使用する場合、以下のようなパターンが一般的にあります。

`.*`：これは任意の文字（.）が0回以上（*）繰り返すパターンを表します。

`[^/]*`：これはスラッシュ以外の任意の文字（[^/]）が0回以上（*）繰り返すパターンを表します。
つまり、スラッシュを含まない任意の文字列（つまり、ディレクトリ名）にマッチします。

`[^/]*$`：これはスラッシュを含まない任意の文字列（[^/]*）が行の終わり（$）にあるパターンを表します。
つまり、パスの最後の部分（つまり、最後のディレクトリ名またはファイル名）にマッチします。

これらの正規表現は、ディレクトリの場所を表現するための基本的なパターンです。

## 注意点

この設定はexperimentalなものなので、将来的にどうなるかは不明です。もし使えなくなった場合でも、画像のコピペは別ツールの Obsidian や MarkText の同等機能で代替可能です。

## 画像圧縮を行うには

Microsoftの`learn-images`というVSCode拡張を使うと、フォルダ内の画像をまとめて縮小・圧縮できます。
コンテキストメニューにフォルダ内の画像を圧縮する項目が追加されます。
実行すると、大きな画像を適切なサイズに縮小してくれます。
この拡張機能は Microsoft Learn の編集者向けツール `vscode-docs-authoring` の一部として提供されています。

[vscode-docs-authoring](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-images)
![Alt text](/assets/images/2023-07-21-vscode-settings-for-pasting-images-into-markdown/image-1.png)
![Alt text](/assets/images/2023-07-21-vscode-settings-for-pasting-images-into-markdown/image-2.png)
---

以上、VSCodeでクリップボードの画像をそのままMarkdownに貼り付ける方法についての説明でした。
この機能を活用して、より効率的なmarkdownの作成を行ってみてください。