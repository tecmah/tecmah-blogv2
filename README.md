# tecmah-blogv2

## TECMAHのBLOGです

blogのファーストバージョンはtecmah-blogになります。
Hexoで構築しましたが、githubpageによる運用が大変になってきたので
作り直しました

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
$ bundle exec jekyll publish _drafts/my-new-draft.md --date 2014-01-24
#  specify a custom format for the date attribute in the yaml front matter
$ bundle exec jekyll publish _drafts/my-new-draft.md --timestamp-format "%Y-%m-%d %H:%M:%S %z"


```

## rubyインストール

rubyはrbenvでの管理を推奨しています。
現在のversionは3.2.2で動作させています。

## Jekyllのインストール

Jekyll公式の解説に沿ってインストールしてください。

## Jekeyllyの初期セットアップ

## テンプレート

## ローカルでのプレビュー

bundle exec jekyll serve

# github Action　test

gh workflow run jekyll.yml --ref main
gh run list --workflow=jekyll.yml

## GithubPageの設定

