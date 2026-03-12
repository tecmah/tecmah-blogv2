# Git Flow セットアップガイド

このガイドでは、tecmah-blogv2リポジトリでGit Flowブランチ戦略を開始するための手順を説明します。

## 🎯 目的

GitHub Pagesブログに対して、Git Flowブランチ戦略を導入し、開発プロセスを改善します。

## 📋 前提条件

- リポジトリへの管理者権限
- GitHub CLI (`gh`) のインストール（オプション）
- Git の基本的な理解

## 🚀 初回セットアップ手順

### Step 1: ブランチの作成

現在のリポジトリには `main` ブランチが存在しないため、以下の手順でブランチを作成します：

```bash
# 1. 現在のブランチから main ブランチを作成
git checkout -b main
git push origin main

# 2. develop ブランチを作成
git checkout -b develop
git push origin develop

# 3. デフォルトブランチを develop に変更（GitHubのWebインターフェースで実施）
# Settings → Branches → Default branch → develop
```

### Step 2: GitHub リポジトリ設定

#### デフォルトブランチの変更

1. GitHubのリポジトリページにアクセス
2. **Settings** → **Branches**
3. **Default branch** を `develop` に変更
4. **Update** をクリック

#### 自動削除の有効化

1. **Settings** → **General** → **Pull Requests**
2. ✅ **Automatically delete head branches** を有効化

### Step 3: ブランチ保護ルールの設定

詳細は [BRANCH_PROTECTION.md](.github/BRANCH_PROTECTION.md) を参照してください。

#### `main` ブランチの保護（必須）

```bash
# GitHub CLI を使用する場合
gh api repos/tecmah/tecmah-blogv2/branches/main/protection \
  --method PUT \
  -f required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  -f required_status_checks='{"strict":true,"contexts":["build"]}' \
  -f enforce_admins=true \
  -f required_conversation_resolution=true \
  -f required_linear_history=true \
  -f allow_force_pushes=false \
  -f allow_deletions=false
```

または、GitHubのWebインターフェースで：

1. **Settings** → **Branches** → **Add branch protection rule**
2. Branch name pattern: `main`
3. 以下を有効化：
   - ✅ Require a pull request before merging (1 approval)
   - ✅ Require status checks to pass before merging
   - ✅ Require conversation resolution before merging
   - ✅ Require linear history
   - ✅ Include administrators

#### `develop` ブランチの保護（推奨）

1. **Settings** → **Branches** → **Add branch protection rule**
2. Branch name pattern: `develop`
3. 以下を有効化：
   - ✅ Require a pull request before merging (1 approval)
   - ✅ Require status checks to pass before merging
   - ✅ Require conversation resolution before merging

### Step 4: GitHub Pages の設定確認

1. **Settings** → **Pages**
2. **Source**: GitHub Actions（すでに設定済み）
3. **Branch**: デプロイは `main` ブランチのみ（ワークフローで制御）
4. **Custom domain**: `blog.tecmah.com`（すでに設定済み）

### Step 5: GitHub Actions の確認

`.github/workflows/jekyll.yml` の設定を確認：

- ✅ `main` ブランチへのプッシュで本番デプロイ
- ✅ `main` と `develop` へのPRでビルド検証
- ✅ デプロイは `main` ブランチのプッシュ時のみ実行

## 📝 運用開始

### 最初の機能開発

```bash
# 1. develop ブランチをチェックアウト
git checkout develop
git pull origin develop

# 2. feature ブランチを作成
git checkout -b feature/update-git-flow-docs

# 3. 変更を加えてコミット
git add .
git commit -m "Add: Git Flow documentation"

# 4. プッシュしてPR作成
git push origin feature/update-git-flow-docs
gh pr create --base develop --head feature/update-git-flow-docs \
  --title "Add: Git Flow documentation" \
  --body "Git Flow運用のためのドキュメントを追加"
```

### 最初のリリース

```bash
# 1. develop から release ブランチを作成
git checkout develop
git checkout -b release/2026-03-12

# 2. リリース準備（必要に応じて）
# バージョン番号の更新など

# 3. プッシュして main への PR を作成
git push origin release/2026-03-12
gh pr create --base main --head release/2026-03-12 \
  --title "Release: 2026-03-12" \
  --body "Git Flow運用開始のための初回リリース"

# 4. main にマージ後、develop にも反映
git checkout develop
git merge release/2026-03-12
git push origin develop

# 5. release ブランチを削除
git branch -d release/2026-03-12
git push origin --delete release/2026-03-12
```

## ✅ セットアップ完了チェックリスト

### ブランチ構成
- [ ] `main` ブランチが作成され、本番用として設定されている
- [ ] `develop` ブランチが作成され、デフォルトブランチに設定されている
- [ ] 両ブランチが同期されている

### ブランチ保護
- [ ] `main` ブランチにプルリクエストが必須の保護ルールが設定されている
- [ ] `main` ブランチにステータスチェック（build）が必須に設定されている
- [ ] `develop` ブランチに適切な保護ルールが設定されている

### GitHub Pages
- [ ] Source が "GitHub Actions" に設定されている
- [ ] カスタムドメイン `blog.tecmah.com` が設定されている
- [ ] `main` ブランチへのプッシュで自動デプロイされることを確認

### GitHub Actions
- [ ] `.github/workflows/jekyll.yml` が更新されている
- [ ] PR作成時にビルドが実行されることを確認
- [ ] `main` へのプッシュでデプロイが実行されることを確認

### ドキュメント
- [ ] `README.md` にブランチ戦略の説明が追加されている
- [ ] `CONTRIBUTING.md` が作成されている
- [ ] `.github/BRANCH_PROTECTION.md` が作成されている
- [ ] チームメンバーにドキュメントを共有している

## 🔄 移行期間の対応

既存の作業中のブランチがある場合：

```bash
# 既存の feature ブランチを develop にリベース
git checkout your-feature-branch
git fetch origin
git rebase origin/develop

# コンフリクトが発生した場合は解決してから
git rebase --continue

# リベース後にプッシュ（force push が必要）
git push --force-with-lease origin your-feature-branch
```

## 📚 参考資料

- [CONTRIBUTING.md](../CONTRIBUTING.md) - 詳細なGit Flow運用ガイド
- [BRANCH_PROTECTION.md](.github/BRANCH_PROTECTION.md) - ブランチ保護設定の詳細
- [Git Flow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) - Git Flow の公式ドキュメント

## 🆘 トラブルシューティング

### main ブランチが存在しない

現在のブランチから作成してください：

```bash
git checkout -b main
git push origin main
```

### ブランチ保護ルールが設定できない

管理者権限を確認してください。または、リポジトリオーナーに設定を依頼してください。

### デプロイが実行されない

1. GitHub Actions のログを確認
2. `main` ブランチへのプッシュかどうか確認
3. ワークフローの `if` 条件が正しいか確認

## 📞 サポート

問題や質問がある場合は、GitHubのIssueを作成してください。

---

**注意**: このセットアップガイドは初回セットアップ時にのみ必要です。セットアップ完了後は、[CONTRIBUTING.md](../CONTRIBUTING.md)の運用ガイドに従ってください。
