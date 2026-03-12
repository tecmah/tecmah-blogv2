# Contributing to TECMAH Blog

このドキュメントでは、TECMAH Blogへの貢献方法とGit Flowブランチ運用戦略について説明します。

## ブランチ戦略（Git Flow）

このプロジェクトでは、GitHub Pagesでの運用に最適化されたGit Flowブランチ戦略を採用しています。

### ブランチの種類

#### 1. `main` ブランチ（本番環境）
- **目的**: 本番環境（GitHub Pages）へのデプロイ用
- **保護**: 直接のプッシュは禁止
- **デプロイ**: このブランチへのマージで自動的にGitHub Pagesにデプロイされます
- **マージ元**: `release/*` ブランチまたは `hotfix/*` ブランチのみ

#### 2. `develop` ブランチ（開発統合環境）
- **目的**: 開発中の機能を統合するブランチ
- **保護**: 直接のプッシュは推奨されません
- **マージ元**: `feature/*` ブランチ
- **マージ先**: `release/*` ブランチ

#### 3. `feature/*` ブランチ（機能開発）
- **目的**: 新機能や記事の追加開発
- **命名規則**: `feature/[機能名]` または `feature/[issue番号]-[簡潔な説明]`
- **例**:
  - `feature/add-new-post`
  - `feature/123-improve-seo`
  - `feature/update-about-page`
- **派生元**: `develop` ブランチ
- **マージ先**: `develop` ブランチ

#### 4. `release/*` ブランチ（リリース準備）
- **目的**: リリース前の最終調整とテスト
- **命名規則**: `release/YYYY-MM-DD` または `release/v1.0.0`
- **例**:
  - `release/2026-03-12`
  - `release/v1.2.0`
- **派生元**: `develop` ブランチ
- **マージ先**: `main` ブランチと `develop` ブランチ（両方）

#### 5. `hotfix/*` ブランチ（緊急修正）
- **目的**: 本番環境の緊急バグ修正
- **命名規則**: `hotfix/[問題の説明]` または `hotfix/[issue番号]-[簡潔な説明]`
- **例**:
  - `hotfix/fix-broken-link`
  - `hotfix/456-security-patch`
- **派生元**: `main` ブランチ
- **マージ先**: `main` ブランチと `develop` ブランチ（両方）

## ワークフロー

### 新機能・記事の追加

```bash
# 1. developブランチから最新の状態を取得
git checkout develop
git pull origin develop

# 2. 機能ブランチを作成
git checkout -b feature/your-feature-name

# 3. 変更を加えて、コミット
bundle exec jekyll serve --drafts  # ローカルで確認
git add .
git commit -m "Add: 新機能の説明"

# 4. リモートにプッシュ
git push origin feature/your-feature-name

# 5. Pull Requestを作成（develop ← feature/your-feature-name）
gh pr create --base develop --head feature/your-feature-name \
  --title "新機能: 機能の説明" \
  --body "## 概要
[機能の説明]

## 変更内容
- [ ] 変更1
- [ ] 変更2

## テスト
- [ ] ローカルでのビルド確認
- [ ] 記事の表示確認"
```

### リリース手順

```bash
# 1. developブランチから最新の状態を取得
git checkout develop
git pull origin develop

# 2. リリースブランチを作成
git checkout -b release/$(date +%Y-%m-%d)

# 3. リリース準備（バージョン番号の更新など）
# _config.ymlや必要なファイルの更新

# 4. リモートにプッシュ
git push origin release/$(date +%Y-%m-%d)

# 5. Pull Requestを作成（main ← release/YYYY-MM-DD）
gh pr create --base main --head release/$(date +%Y-%m-%d) \
  --title "Release: $(date +%Y-%m-%d)" \
  --body "## リリース内容
[リリースの説明]

## チェックリスト
- [ ] ビルドが成功することを確認
- [ ] 全ての機能が正常に動作することを確認
- [ ] 記事の表示に問題がないことを確認"

# 6. mainにマージ後、developにもマージ
git checkout develop
git merge release/$(date +%Y-%m-%d)
git push origin develop

# 7. リリースブランチを削除
git branch -d release/$(date +%Y-%m-%d)
git push origin --delete release/$(date +%Y-%m-%d)
```

### 緊急修正（Hotfix）

```bash
# 1. mainブランチから緊急修正ブランチを作成
git checkout main
git pull origin main
git checkout -b hotfix/fix-critical-bug

# 2. 修正を加えてコミット
git add .
git commit -m "Fix: 緊急バグの修正"

# 3. リモートにプッシュ
git push origin hotfix/fix-critical-bug

# 4. Pull Requestを作成（main ← hotfix/fix-critical-bug）
gh pr create --base main --head hotfix/fix-critical-bug \
  --title "Hotfix: バグ修正の説明" \
  --body "## 問題
[バグの説明]

## 修正内容
[修正の説明]

## テスト
- [ ] バグが修正されたことを確認"

# 5. mainにマージ後、developにもマージ
git checkout develop
git pull origin develop
git merge hotfix/fix-critical-bug
git push origin develop

# 6. hotfixブランチを削除
git branch -d hotfix/fix-critical-bug
git push origin --delete hotfix/fix-critical-bug
```

## コミットメッセージ規約

明確なコミットメッセージを使用してください：

- `Add:` 新機能や新しい記事の追加
- `Update:` 既存機能や記事の更新
- `Fix:` バグ修正
- `Refactor:` リファクタリング
- `Docs:` ドキュメントのみの変更
- `Style:` コードの意味に影響しない変更（空白、フォーマットなど）
- `Test:` テストの追加や修正
- `Chore:` ビルドプロセスや補助ツールの変更

例：
```
Add: ブログ記事「Ruby on Railsの基礎」を追加
Update: 会社概要ページの情報を更新
Fix: ナビゲーションメニューのリンク切れを修正
```

## Pull Request（PR）ガイドライン

### PRを作成する前に

- [ ] ローカルでビルドが成功することを確認
  ```bash
  bundle exec jekyll build
  ```
- [ ] ローカルでサイトが正しく表示されることを確認
  ```bash
  bundle exec jekyll serve --drafts
  ```
- [ ] コミットメッセージが明確で分かりやすい
- [ ] 不要なファイルがコミットされていない

### PRの説明

PRには以下の情報を含めてください：

1. **概要**: 変更の目的と背景
2. **変更内容**: 主な変更点のリスト
3. **テスト**: 実施したテストの内容
4. **スクリーンショット**: UI変更がある場合

### レビュープロセス

- PRは最低1人のレビュアーによる承認が必要です
- レビューコメントには24時間以内に返信してください
- 全てのコメントが解決されるまでマージしません

## ローカル開発環境

### 必要な環境

- Ruby 3.2.2（rbenvでの管理を推奨）
- Bundler
- Jekyll 4.3.2+

### セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/tecmah/tecmah-blogv2.git
cd tecmah-blogv2

# developブランチをチェックアウト
git checkout develop

# 依存関係をインストール
bundle install

# ローカルサーバーを起動
bundle exec jekyll serve --drafts
```

### ローカルでの確認

- トップページ: http://localhost:4000/
- 会社概要: http://localhost:4000/menu/company/
- サービス: http://localhost:4000/menu/services/
- ブログ一覧: http://localhost:4000/blog.html

## ブログ記事の作成

### 下書きの作成

```bash
bundle exec jekyll draft "記事のタイトル"
```

### 下書きの公開

```bash
bundle exec jekyll publish _drafts/記事のファイル名.md --date $(date +%Y-%m-%d)
```

### 記事のアンパブリッシュ

```bash
bundle exec jekyll unpublish _posts/YYYY-MM-DD-記事のファイル名.md
```

## 質問やサポート

問題や質問がある場合は、GitHubのIssueを作成してください。

---

**注意**: このドキュメントは随時更新されます。最新の情報を確認するようにしてください。
