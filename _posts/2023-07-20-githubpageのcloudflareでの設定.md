---
layout: post
title: Cloudflare設定変更によるリダイレクトループエラーの解決
category: development
image: "/assets/images/image.png"
tags: error githubPage cloudflare DNS SSL/TLS
date: 2023-07-20 00:00 +0000
---
![Alt text](/assets/images/image.png)

---

こんにちは、皆さん。

今日は私が直面したトラブルとその解決方法についてお話ししたいと思います。

「Cloudflare設定変更によるリダイレクトループエラーの解決」です。

&nbsp;

まず始めに、私のウェブサイトはGitHubでJekyllを使用して作成し、ドメインはお名前.comからCloudflareに移行しました。

&nbsp;

しかし、移行後に問題が発生しました。「このページは動作していませんwww.tecmah.comでリダイレクトが繰り返し行われました。」というエラーメッセージが表示されるようになったのです。

&nbsp;

リダイレクトループ、すなわち無限リダイレクトは、ブラウザが同じURLに何度もリダイレクトしようとすると発生します。通常、これは設定の不整合や誤設定によるものです。

&nbsp;

まず、GitHubの設定を確認しました。私のリポジトリの設定に移動し、GitHub Pagesセクションを見ました。ここで、「Custom domain」が私のドメイン名である `www.tecmah.com` に設定されていることを確認しました。

&nbsp;

次に、Cloudflareの設定を見直しました。私のドメイン名がGitHub PagesのIPアドレスに正しくポイントされていることを確認しました。そして、ここで問題を見つけました。CloudflareのSSL/TLS設定が "Flexible" になっていました。

&nbsp;

"Flexible" とは、クライアント（ブラウザなど）とCloudflareの間ではSSLを使用しますが、Cloudflareとサーバー（GitHub Pages）の間ではSSLを使用しない設定です。

&nbsp;

この設定では、CloudflareとGitHub Pagesとの間の接続が平文（未暗号化）で行われ、GitHub Pagesが安全な接続を強制しているためにリダイレクトループが発生していました。

&nbsp;

そこで、私はCloudflareのSSL/TLS設定を "Full" に変更しました。すると、エラーメッセージは消え、ウェブサイトが正常に動作するようになりました。

![Alt text](/assets/images/image1.png)
&nbsp;

この経験から学んだことは、設定を変更したり新しいサービスを導入したりするときは、全ての設定を注意深く確認することの重要性です。そして、問題が発生したときは、一つひとつの設定を丁寧に見直すことで解決の糸口を見つけることができるということです。

&nbsp;

皆さんもこの記事が何かの参考になれば幸いです。トラブルがあったときは落ち着いて対処しましょう。

それでは、次回の記事でお会いしましょう。