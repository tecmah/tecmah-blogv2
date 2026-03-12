# ブランチ保護ルールの設定

このドキュメントでは、Git Flowを適切に運用するためのGitHubブランチ保護ルールの推奨設定を説明します。

## 推奨されるブランチ保護設定

### `main` ブランチの保護

`main`ブランチは本番環境にデプロイされるため、最も厳格な保護が必要です。

#### 設定手順

1. GitHubリポジトリページにアクセス
2. **Settings** → **Branches** → **Add branch protection rule**
3. Branch name pattern: `main`
4. 以下の設定を有効化：

#### 必須設定

- ✅ **Require a pull request before merging**
  - ✅ Require approvals: **1** 以上
  - ✅ Dismiss stale pull request approvals when new commits are pushed
  - ✅ Require review from Code Owners（オプション）

- ✅ **Require status checks to pass before merging**
  - ✅ Require branches to be up to date before merging
  - 必須ステータスチェック:
    - `build` (Jekyll build job)

- ✅ **Require conversation resolution before merging**
  - すべてのレビューコメントが解決されていることを確認

- ✅ **Do not allow bypassing the above settings**
  - 管理者も含めてルールを適用

#### 推奨設定

- ✅ **Require linear history**
  - クリーンな履歴を維持するため、マージコミットを禁止

- ✅ **Include administrators**
  - 管理者にもルールを適用（推奨）

- ⚠️ **Allow force pushes**: 無効（デフォルト）
- ⚠️ **Allow deletions**: 無効（デフォルト）

### `develop` ブランチの保護

`develop`ブランチは統合ブランチとして、`main`より柔軟だが保護が必要です。

#### 設定手順

1. GitHubリポジトリページにアクセス
2. **Settings** → **Branches** → **Add branch protection rule**
3. Branch name pattern: `develop`
4. 以下の設定を有効化：

#### 必須設定

- ✅ **Require a pull request before merging**
  - Require approvals: **1** 以上（小規模チームの場合は0でも可）
  - ✅ Dismiss stale pull request approvals when new commits are pushed

- ✅ **Require status checks to pass before merging**
  - ✅ Require branches to be up to date before merging
  - 必須ステータスチェック:
    - `build` (Jekyll build job)

- ✅ **Require conversation resolution before merging**

#### 推奨設定

- ⚠️ **Allow force pushes**: 無効（デフォルト）
- ⚠️ **Allow deletions**: 無効（デフォルト）

### `feature/*`, `release/*`, `hotfix/*` ブランチ

これらのブランチは一時的なブランチのため、特別な保護ルールは不要ですが、以下のベストプラクティスを推奨します：

- 作業完了後は速やかに削除
- 長期間放置しない（最大2週間を目安）
- 定期的にベースブランチの変更を取り込む

## GitHub Pagesの設定

### デプロイ設定

1. **Settings** → **Pages**
2. **Source**: GitHub Actions
3. **Branch**: `main` ブランチからデプロイ
4. **Custom domain**: `blog.tecmah.com`（設定済み）

### 環境（Environments）の設定

#### `github-pages` 環境

1. **Settings** → **Environments** → **github-pages**
2. 以下の設定を確認：

- ✅ **Deployment branches**: `main` のみ
- ✅ **Required reviewers**: 本番デプロイ前のレビューが必要な場合に設定（オプション）
- ✅ **Wait timer**: デプロイ前の待機時間（オプション、通常は0分）

## リポジトリ設定

### 一般設定

**Settings** → **General**

- ✅ **Default branch**: `develop`
  - 新しいPRのデフォルトのベースブランチとして`develop`を設定

- ✅ **Allow merge commits**: 有効
- ✅ **Allow squash merging**: 有効（推奨）
- ✅ **Allow rebase merging**: 有効
- ⚠️ **Automatically delete head branches**: 有効（推奨）
  - マージ後に自動的にブランチを削除

### Pull Request設定

**Settings** → **General** → **Pull Requests**

- ✅ **Allow auto-merge**: 有効（オプション）
- ✅ **Automatically delete head branches**: 有効（推奨）

## セットアップスクリプト（管理者向け）

以下はGitHub CLIを使用したブランチ保護ルールの設定例です：

```bash
# mainブランチの保護ルール
gh api repos/tecmah/tecmah-blogv2/branches/main/protection \
  --method PUT \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field required_status_checks='{"strict":true,"contexts":["build"]}' \
  --field enforce_admins=true \
  --field required_conversation_resolution=true \
  --field required_linear_history=true \
  --field allow_force_pushes=false \
  --field allow_deletions=false

# developブランチの保護ルール
gh api repos/tecmah/tecmah-blogv2/branches/develop/protection \
  --method PUT \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field required_status_checks='{"strict":true,"contexts":["build"]}' \
  --field required_conversation_resolution=true \
  --field allow_force_pushes=false \
  --field allow_deletions=false
```

## 確認チェックリスト

ブランチ保護が正しく設定されているか確認：

### `main` ブランチ
- [ ] 直接プッシュができない
- [ ] PRが必要
- [ ] 1人以上の承認が必要
- [ ] ビルドが成功しないとマージできない
- [ ] すべてのコメントが解決されないとマージできない

### `develop` ブランチ
- [ ] PRが推奨される
- [ ] ビルドが成功しないとマージできない

### デプロイ
- [ ] `main`ブランチへのプッシュで自動的にGitHub Pagesにデプロイされる
- [ ] PRに対してはビルドのみ実行され、デプロイはされない

## トラブルシューティング

### mainブランチに直接プッシュできてしまう

ブランチ保護ルールが正しく設定されていない可能性があります。Settings → Branches で設定を確認してください。

### ビルドは成功するがデプロイされない

1. GitHub Actions のワークフローログを確認
2. `if: github.event_name == 'push' && github.ref == 'refs/heads/main'` の条件が正しいか確認
3. GitHub Pages の設定で Source が "GitHub Actions" になっているか確認

### PRをマージできない

1. すべてのステータスチェックが成功しているか確認
2. 必要な承認数が満たされているか確認
3. すべてのレビューコメントが解決されているか確認

## 参考リンク

- [GitHub: About protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [GitHub: Configuring a publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
- [Git Flow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

---

**注意**: これらの設定を適用するには、リポジトリの管理者権限が必要です。
