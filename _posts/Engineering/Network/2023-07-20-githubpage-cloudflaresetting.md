---
layout: post
title: GithubPageのCloudflareの設定
subtitle: Cloudflare設定変更によるリダイレクトループエラーの解決
banner:
    image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/32977341-319c-4e8d-8f2c-857c70c0d35f
    opacity: 0.3
categories:
    - Engineering
tags: 
    - Network
date: 2023-07-19 00:00 +0000
---
![Alt text](https://github.com/tecmah/tecmah-blogv2/assets/11237144/122e517d-1135-4a2d-81de-4804fffed657)

---

みなさん、こんにちは。

今回は、「Cloudflareの設定変更によるリダイレクトループエラーの解決」について、私の経験を基に解説します。

## 目次

1. [問題の発生](#問題の発生)
2. [原因の探求](#原因の探求)
3. [問題の解決](#問題の解決)
4. [結び](#結び)

## 問題の発生

私のウェブサイトはGitHubでJekyllを使用し、ドメインはお名前.comからCloudflareに移行しました。しかし、移行後に問題が生じ、「このページは動作していませんwww.tecmah.comでリダイレクトが繰り返し行われました」というエラーメッセージが出るようになりました。

この問題は、リダイレクトループと呼ばれ、ブラウザが同じURLに何度もリダイレクトしようとする現象を指します。通常、これは設定の不整合や誤設定により生じます。

## 原因の探求

エラーの解消に向け、まずGitHubの設定をチェックしました。私のリポジトリの設定を開き、「GitHub Pages」セクションで、「Custom domain」が私のドメイン名、すなわち `www.tecmah.com` に設定されていることを確認しました。

次に、Cloudflareの設定を確認し、ドメイン名がGitHub PagesのIPアドレスを正しく指していることを見つけました。しかし、ここで問題を発見しました。CloudflareのSSL/TLS設定が "Flexible" に設定されていました。

この "Flexible" 設定は、クライアント（ブラウザなど）とCloudflare間はSSLを使用しますが、Cloudflareとサーバー（GitHub Pages）間ではSSLを使用しない設定です。このため、CloudflareとGitHub Pages間の接続が平文（未暗号化）で行われ、GitHub Pagesがセキュアな接続を強制するためリダイレクトループが生じていました。

## 問題の解決

エラーの解決策として、私はCloudflareのSSL/TLS設定を "Full" に変更しました。この変更によりエラーメッセージが消え、ウェブサイトが正常に動作するようになりました。
![Alt text](https://github.com/tecmah/tecmah-blogv2/assets/11237144/70d168b9-ea30-429e-a7d7-dbce165ed45a)

## 結び

この経験から得られた教訓は、設定を変更したり新しいサービスを導入したりするときには、すべての設定を慎重に確認することが重要だということです。また、問題が発生したときには、各設定を丁寧に見直すことで解決策を見つけることが可能だということです。

この記事が皆さんの何かの参考になれば幸いです。トラブルに遭遇したときは、落ち着いて対応しましょう。それでは、次回の記事でお会いしましょう。
