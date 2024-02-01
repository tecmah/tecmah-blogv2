---
layout: post
title: Githubが2段階認証を強制適用する件
banner:
    image: https://github.com/tecmah/tecmah-blogv2/assets/11237144/493208f5-7417-445e-a03f-daf7424b5002
    opacity: 0.3
category: General
tags: Github 2FA
date: 2023-08-11 08:39:39 +0900
---

github-to-enforce-two-step-verification

✨皆さん、こんにちは！今回は、Githubが2段階認証を強制適用するというニュースをお届けします！
Github本社はGithubがより安全な環境を提供するために、2段階認証を2023年末までに強制適用することを決定しました。
この記事では、なぜ2段階認証が重要なのか、どのように設定するのか、そしてその利点について詳しく説明していきます。さあ、一緒に見ていきましょう！

## 目次

1. [なぜ2段階認証が重要なのか](#なぜ2段階認証が重要なのか)
2. [2段階認証の設定方法](#2段階認証の設定方法)
3. [2段階認証の利点](#2段階認証の利点)
4. [最後に](#最後に)

## なぜ2段階認証が重要なのか

---

✨Githubが2段階認証を強制適用する理由は、セキュリティをより強化し、アカウントの不正アクセスを防ぐためです。
2段階認証とは、通常のパスワードに加えて、ユーザーが所有するデバイス（携帯電話など）から生成される一時的な認証コードを入力することによって、アカウントへのアクセスを保護する仕組みです。
これにより、不正なログイン試行やパスワードの漏洩による被害を最小限に抑えることができます。

2段階認証を使わないと、パスワードが漏洩した場合にアカウントが乗っ取られる可能性があります。
しかし、2段階認証を有効にすることで、不正アクセスを防ぐことができます。
皆さんのプライベートなリポジトリや貴重なコードを守るために、ぜひ2段階認証を設定しましょう！

## 2段階認証の設定方法

---

２段階認証で一番新しいものは、iOSとAndroidに対応したGitHub Mobile用の2要素認証があります。
TOTPモバイルアプリとは異なる認証方法でGitHub Mobileを使った２段階認証は、TOTPを利用せず、代わりに公開キー暗号化を使ってアカウントをセキュリティで保護するものです。

しかしGitHub Mobileを使った２段階認証は事前にTOTPモバイルアプリかSMSでの２段階認証の登録が必要になります。

まずは２段階認証の設定では
・TOTPモバイルアプリを使用した２段階認証
・SMSでの２段階認証
を設定しましょう。

[Github公式-二要素認証について](https://docs.github.com/ja/authentication/securing-your-account-with-two-factor-authentication-2fa/about-two-factor-authentication)

### TOTPモバイルアプリを使用した２段階認証のやりかた

TOTPのアプリケーションは様々なものがあります。
・Google Authenticator
・IIJ SmartKey
・Twilio Authy
・Microsoft Authenticator
・Authy
全部使っても意味がないので一つだけ使用すればいいでしょう。

この中で一番使用されているのは`Google Authenticator`の為、今回はこちらで説明します。
英語でも大丈夫という方は`Twilio Authy`もおすすめです。

使い方は単純で、[Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&pcampaignid=web_share)アプリをインストール

![image](https://github.com/tecmah/tecmah-blogv2/assets/11237144/047477d2-4653-47d2-b4f8-592f36d62847)

プラスのようなボタンを押して**QRコードをスキャン**を選択します。
このスキャン画面でGithubで使用する２段階認証のQRを読み込めばOKです。

### Githubで２段階認証のQRを表示するまでの方法

2段階認証の設定方法はとても簡単です。
まずは、Githubの設定画面にアクセスし、アイコンをクリックしてSettigの画面をひらきます。

![Alt text](https://docs.github.com/assets/cb-65929/mw-1440/images/help/settings/userbar-account-settings.webp)

次にパスワードと認証の項目を選択します。

![image-1 (2)](https://github.com/tecmah/tecmah-blogv2/assets/11237144/17a22ebe-d662-4783-be5e-26bae88764b6)

Two-factor authenticationの項目でAuthenticator appので`Add`既に登録してあれば`Edit`を選びましょう。

![image-2 (2)](https://github.com/tecmah/tecmah-blogv2/assets/11237144/617fbbc8-2dd3-4e9a-996e-0360973b7057)

QRコードが出てくればアプリでスキャンして設定完了です！

## 2段階認証の利点

2段階認証の利点は多岐にわたります。
まず、セキュリティが強化されることにより、アカウントへの不正アクセスを防ぐことができます。
また、万が一パスワードが漏洩した場合でも、2段階認証によりアカウントを保護することができます。

さらに、2段階認証は開発者にとっても利点があります。
例えば、自分のコードやプロジェクトを他の人と共有する際に、より安心して情報を共有することができます。
また、チームで開発を行う場合でも、メンバーのアカウントが安全に保たれるため、プロジェクト全体のセキュリティが向上します。

## 最後に

✨2段階認証は、Githubのセキュリティを向上させるための重要な手段です。
アカウントの安全性を高めるために、ぜひ2段階認証を有効にしてください！もし何か質問やご意見があれば、お気軽にコメントしてください。
私たちのSNSアカウントもフォローしていただけると嬉しいです。安全な開発をお楽しみください！

[TECMAHのTwitter](https://twitter.com/infoTECMAH)をフォローして、最新の技術情報を入手しましょう！

Githubの2段階認証が強制適用されることで、不正アクセスを試みる悪意あるハッカーたちが悲鳴を上げていることでしょう！
せっかくの悪事が阻止されるなんて、彼らにとっては本当に不運ですね。
まあ、彼らの人生にユーモアを加えることはできませんが、私たちが安全に開発を続けることはできます！

## 読者への質問

皆さんは、2段階認証をすでに利用していますか？もしまだ設定していない場合は、なぜ設定しないのか考えてみてください。
自分のアカウントとプロジェクトを守るために、2段階認証を有効にすることをおすすめします！

以上で、Githubが2段階認証を強制適用する件についての記事をお送りしました。安全な開発をお楽しみください！