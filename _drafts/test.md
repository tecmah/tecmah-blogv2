---
layout: post
title: JekyllとGithub pageでBLOGをリニューアル
tag: update
---


# ai blog create
ruby app/models/main.rb


# asciinema

## rec
asciinema rec 
asciinema rec /Users/yono/Bild/blog/tecmah-blogv2/assets/ascinema/$(date +%Y%m%d%H%M%S).cast

# play

asciinema play /path/to/asciicast.cast
asciinema rec filename.cast


## categoryの管理

日本十進分類法（NDC）

一般 　General
哲学　Philosophy
歴史　History
社会科学　Social Sciences
自然科学　Natural Sciences
応用科学・Applied Sciences 
工学　  Engineering
芸術・スポーツ Arts and Sports
    食事系　Food-related (under Arts and Sports)
言語・文学　Language and Literature
文化・教養　Culture and Education
地理・歴史・伝記　Geography, History, and Biography


## tag
### ACM Computing Classification System (ACM CCS)

Hardware: コンピュータハードウェア、プロセッサ、メモリ、入出力デバイスなどのトピック
Software: ソフトウェア開発、プログラミング言語、ソフトウェアエンジニアリングなどのトピック
Computer Systems Organization: コンピュータシステムの設計、アーキテクチャ、オペレーティングシステムなどのトピック
Networks: ネットワーク技術、プロトコル、通信システムなどのトピック
Security and Privacy: セキュリティ、プライバシー、暗号化などのトピック
Software Engineering: ソフトウェア開発プロセス、テスト、品質管理などのトピック
Information Systems: 情報システム、データベース、情報管理などのトピック
Artificial Intelligence: 人工知能、機械学習、知識処理などのトピック
Theory of Computation: 計算理論、アルゴリズム、複雑性理論などのトピック
Human-Computer Interaction: ユーザーインターフェース、ユーザビリティ、対話デザインなどのトピック

```zsh
# new post
bundle exec jekyll post "My New Page"
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
