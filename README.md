# tecmah-blogv2

## TECMAHのBLOGです

blogのファーストバージョンは[tecmah-blog](https://github.com/tecmah/tecmah-blog)になります。
Hexoで構築しましたが、githubpageによる運用が大変になってきたので
作り直しました
jekyllで作成しなおしています。

## blog記事作成のコマンド

[Jekyll::Compose 公式](https://github.com/jekyll/jekyll-compose)

```zsh
# new post
bundle exec jekyll page "My New Page"
# draft
bundle exec jekyll draft "My new draft"
# draft rename
bundle exec jekyll rename _drafts/my-new-draft.md "My Renamed Draft"
# specify a specific date on which to publish it
bundle exec jekyll publish _drafts/my-new-draft.md --date 2014-01-24
# specify a custom format for the date attribute in the yaml front matter
bundle exec jekyll publish _drafts/my-new-draft.md --timestamp-format "%Y-%m-%d %H:%M:%S %z"
# Unpublish your post using
bundle exec jekyll unpublish _posts/2014-01-24-my-new-draft.md
```

## rubyインストール

rubyはrbenvでの管理を推奨しています。
現在のversionは3.2.2で動作させています。
rbenvでバージョンを管理するのを推奨しております。

## Jekyllのインストール

Jekyll公式の解説に沿ってインストールしてください。

## Jekeyllyの初期セットアップ

## テンプレート

## ローカルでのプレビュー

bundle exec jekyll serve

## github Action　test

```zsh
gh workflow run jekyll.yml --ref main
gh run list --workflow=jekyll.yml
```

## GithubPageの設定

## AI Command

```zsh
ruby app/models/main.rb app/prompt/General.md 
ruby app/models/main.rb app/prompt/kindle.md 
```
## イメージの最適化

../../asetts
画像をコピーすると自動的にasetts/imagesの配下に画像をアップロードする設定(VSCode)
右クリックComplass imageで行える。
https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-images

## 開発環境

本番ビルドはlinux　開発はMacなので以下を追加してGemfile.lockを定義してます。
bundle lock --add-platform x86_64-linux

### windowsでの開発環境構築

#### WSLのインストール

WSLUbuntu-22.04を使用して開発環境を構築しています。
windowsでの直接の開発環境構築は難があるので推奨できません。

以下は、`rbenv`を使ってRuby 3.2.2をUbuntu 22.04環境にインストールするための手順を簡潔にまとめたものです。

#### 1. 必要なパッケージをインストール

`rbenv`を使用してRubyをビルドするために必要な依存パッケージをインストールします。

```bash
sudo apt update
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev build-essential libbz2-dev libsqlite3-dev libffi-dev libyaml-dev
```

#### 2. `rbenv`と`ruby-build`のインストール

`rbenv`と`ruby-build`をインストールします。

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

#### 3. Ruby 3.2.2のインストール

`rbenv`を使ってRuby 3.2.2をインストールします。

```bash
rbenv install 3.2.2
rbenv global 3.2.2
```

#### 4. インストール確認

インストールが成功したか確認します。

```bash
ruby -v
```



