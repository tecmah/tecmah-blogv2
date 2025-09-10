#!/usr/bin/env bash
set -euo pipefail

# scripts/bootstrap-issues.sh
# 目的:
# - GitHub Issues を詳細手順つきで一括作成（重複はスキップ）
# - 必要ラベルの自動作成
# 前提:
# - リポジトリ直下で実行
# - gh CLI インストール & 認証済み（gh auth status）

ROOT_DIR="$(pwd)"

have() { command -v "$1" >/dev/null 2>&1; }

if ! have gh; then
  echo "[ERROR] gh CLI が見つかりません。macOS: brew install gh" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "[ERROR] gh が未認証です。次を実行: gh auth login (推奨: GitHub.com / HTTPS / ブラウザ)" >&2
  exit 1
fi

repo_name="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
if [[ -z "${repo_name}" ]]; then
  echo "[ERROR] GitHub リポジトリ配下で実行してください。" >&2
  exit 1
fi

echo "[INFO] Repository: ${repo_name}"

RUBY_VER=""
if [[ -f ".ruby-version" ]]; then
  RUBY_VER="$(cat .ruby-version | tr -d '\n\r')"
fi

ensure_label() {
  local name="$1"; shift
  local color="${1:-ededed}"; shift || true
  local desc="${1:-}"; shift || true
  if ! gh label list --limit 200 --json name --jq '.[].name' | grep -Fxq "$name"; then
    gh label create "$name" --color "$color" ${desc:+--description "$desc"} >/dev/null
    echo "[INFO] Created label: $name"
  fi
}

ensure_label "infra" "0e8a16" "Infrastructure"
ensure_label "jekyll" "5319e7" "Jekyll"
ensure_label "good first issue" "7057ff" "Good for newcomers"
ensure_label "ci" "1d76db" "CI"
ensure_label "lfs" "ffab70" "Git LFS"
ensure_label "assets" "c2e0c6" "Assets"
ensure_label "template" "bfd4f2" "Templates"
ensure_label "automation" "f9d0c4" "Automation"
ensure_label "content" "fef2c0" "Content"
ensure_label "quality" "b60205" "Quality"
ensure_label "cdn" "006b75" "CDN"
ensure_label "migration" "d93f0b" "Migration"

exists_issue_title() {
  local title="$1"
  gh issue list --state all --limit 1000 --json title --jq '.[].title' | grep -Fxq "$title" && return 0 || return 1
}

create_issue() {
  local title="$1"; shift
  local labels_csv="$1"; shift
  local generator="$1"; shift || true

  if exists_issue_title "$title"; then
    echo "[SKIP] $title (already exists)"
    return 0
  fi

  tmpfile="$(mktemp)"
  # シェル関数で本文を生成
  "$generator" > "$tmpfile"

  local label_args=()
  IFS="," read -r -a labels <<< "$labels_csv"
  for l in "${labels[@]}"; do
    label_args+=(--label "$l")
  done

  gh issue create --title "$title" --body-file "$tmpfile" "${label_args[@]}" >/dev/null
  rm -f "$tmpfile"
  echo "[OK] Created: $title"
}

# =========================
# Body Generators
# =========================

body_01() {
cat <<'EOF'
### 概要
生成物 `_site/` をリポジトリから除外し、CIでビルド/配信する前提へ切替える。

### 手順（ローカル）
1) `.gitignore` に Jekyll 生成物を追加（既にあればスキップ）
2) 追跡解除（ワークツリーは残す）
3) ローカルビルド確認

```bash
cd /Users/yono/Build/blog/tecmah-blogv2

# 1) .gitignore 追記（重複はそのままでOK）
cat >> .gitignore << 'EOG'
# Jekyll build artifacts
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata
EOG

# 2) 追跡解除（安全）
git rm -r --cached _site || true

git add .gitignore
git commit -m "Stop tracking _site; generate via CI" || true

# 3) Ruby 環境 & ビルド
# rbenv 推奨: brew install rbenv ruby-build
# rbenv install ${RUBY_VER:-3.2.2} || true
# rbenv local ${RUBY_VER:-3.2.2}

bundle install --path vendor/bundle
bundle exec jekyll build --trace
```

### 受け入れ条件
- `git status` に `_site/` が表示されない
- `bundle exec jekyll build` が成功

### 注意点
- システムRubyは古いことが多い → `.ruby-version` に合わせる（現在: ${RUBY_VER:-未設定}）
- 常に `bundle exec` を付ける
EOF
}

body_02() {
cat <<'EOF'
### 概要
`main` へ push 時に Jekyll をビルドし、GitHub Pages で配信する。

### 手順
1) リポジトリ設定 → Pages → Source を「GitHub Actions」に
2) Workflow 追加

```yaml
# .github/workflows/pages.yml
name: Deploy Jekyll to Pages

on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          lfs: true
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: "${RUBY_VER:-3.2.2}"
          bundler-cache: true
      - run: bundle install --path vendor/bundle
      - run: bundle exec jekyll build --trace
      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./_site
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

### 受け入れ条件
- main push で Workflow 成功
- Pages URL でサイト表示

### 注意点
- Pages の Source を必ず「GitHub Actions」に
- LFS 利用時は checkout の `lfs: true`
EOF
}

body_03() {
cat <<'EOF'
### 概要
当面、画像は Git LFS で扱い、容量/差分の悪化を抑える（後日 CDN 移行予定）。

### 手順
```bash
brew install git-lfs || true
git lfs install

git lfs track "assets/images/**"
# 例: 他にも大容量があれば追加: git lfs track "assets/banners/**"

git add .gitattributes

git add assets/images || true
git commit -m "Track images via Git LFS" || true
git push
```

### 受け入れ条件
- `.gitattributes` に LFS 設定が入り、push で LFS が動作

### 注意点
- GitHub LFS の帯域/容量制限に注意
- CI の checkout で `lfs: true` を指定
EOF
}

body_04() {
cat <<'EOF'
### 概要
Markdown は相対パスのまま、テンプレで CDN/相対を切替可能にする。

### 手順
1) `_config.yml` へ追記
```yaml
cdn_base: ""
```
2) `_includes/picture.html` を新規作成
```html
{% assign base = site.cdn_base | default: "" %}
<picture>
  <source srcset="{{ base }}{{ include.src | replace: ".jpg", ".webp" | replace: ".png", ".webp" | relative_url }}" type="image/webp">
  <img loading="lazy" decoding="async" src="{{ base }}{{ include.src | relative_url }}" alt="{{ include.alt | escape }}" width="{{ include.width }}" height="{{ include.height }}">
</picture>
```
3) OGP 参照（例: `_layouts/post.html`）を `cdn_base` 経由へ
```liquid
{% assign base = site.cdn_base | default: "" %}
{% assign ogimg = page.image | default: site.default_image %}
<meta property="og:image" content="{{ base }}{{ ogimg | relative_url }}">
```

### 受け入れ条件
- `cdn_base`=空/本番URL の両方で画像表示

### 注意点
- `.webp` 生成は後続 Issue のスクリプトで対応
EOF
}

body_05() {
cat <<'EOF'
### 概要
画像登録をワンコマンド化（最適化→配置→WebP→スニペット出力）。

### 手順
1) 依存導入
```bash
brew install imagemagick webp || true
```
2) `bin/add-image` を作成
```bash
#!/usr/bin/env bash
set -euo pipefail
src="$1"; slug="$2"  # 例: slug="my-post"
ym="$(date +%Y/%m)"
dir="assets/images/${ym}/${slug}"
mkdir -p "$dir"

base="${dir}/$(basename "$src")"
magick "$src" -strip -auto-orient -resize "1600x1600>" -quality 85 "$base"
cwebp -q 80 "$base" -o "${base%.*}.webp"

echo
echo "{% include picture.html src=\"/${dir}/$(basename "$src")\" alt=\"\" width=\"1200\" height=\"630\" %}"
```
3) 実行権限
```bash
chmod +x bin/add-image
```
4) 使い方
```bash
bin/add-image ~/Downloads/hero.png my-post
```

### 受け入れ条件
- `assets/images/YYYY/MM/slug` に最適化画像+webp を生成
- Markdown に貼る1行が標準出力

### 注意点
- リサイズ/品質は必要に応じて調整
EOF
}

body_06() {
cat <<'EOF'
### 概要
記事ひな型を Rake で作成（スラグ/画像ディレクトリ自動）。

### 手順
`Rakefile` に追加
```ruby
require "fileutils"
require "date"

desc "new post: rake post[\"Title here\"]"
task :post, [:title] do |_, args|
  abort "title required" unless args[:title]
  date = Date.today
  slug = args[:title].downcase.strip.gsub(/[^\w\- ]+/, "").gsub(/[ ]+/, "-")
  path = "_posts/#{date.strftime("%Y-%m-%d")}-#{slug}.md"
  abort "#{path} exists" if File.exist?(path)
  File.write(path, <<~MD)
  ---
  layout: post
  title: "#{args[:title]}"
  date: #{date} 00:00:00 +0900
  categories: [Engineering]
  tags: []
  image: /assets/images/#{date.strftime("%Y/%m")}/#{slug}/hero.jpg
  ---

  <!-- write here -->
  MD
  puts "created #{path}"
  img_dir = "assets/images/#{date.strftime("%Y/%m")}/#{slug}"
  FileUtils.mkdir_p(img_dir)
  puts "image dir: #{img_dir}"
end
```

### 受け入れ条件
- `rake post["My Post"]` で記事+画像ディレクトリ作成

### 注意点
- `bundle exec rake` 推奨
EOF
}

body_07() {
cat <<'EOF'
### 概要
生成 `_site` を HTMLProofer で検証（リンク/画像）。

### 手順（Workflow に追記）
```yaml
- name: HTMLProofer
  run: |
    gem install html-proofer
    htmlproofer ./_site --allow-hash-href --checks-to-ignore ScriptCheck --url-ignore "/localhost/"
```

### 受け入れ条件
- CI で HTMLProofer が実行され、エラー時に失敗

### 注意点
- 外部サイトの不安定性は `--url-ignore` で除外
EOF
}

body_08() {
cat <<'EOF'
### 概要
R2/S3 バケットと CDN を準備。

### 手順（R2例）
1) Cloudflare で R2 バケット `tecmah-blog` 作成
2) S3 互換 Access Key/Secret 発行
3) `cdn.example.com` を R2/Workers などで配信設定
4) GitHub Secrets 登録:
   - `R2_ACCESS_KEY_ID`
   - `R2_SECRET_ACCESS_KEY`
   - `R2_ENDPOINT_URL` = `https://<accountid>.r2.cloudflarestorage.com`
   - `CDN_BASE` = `https://cdn.example.com`

### 受け入れ条件
- CLI で R2 を参照可能
```bash
AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... aws s3 ls \
  --endpoint-url https://<accountid>.r2.cloudflarestorage.com
```

### 注意点
- CORS/キャッシュは CDN 側で制御
EOF
}

body_09() {
cat <<'EOF'
### 概要
CI で画像を R2/S3 に同期し、本番は CDN 経由で配信。

### 手順（Workflow に追記）
```yaml
- name: Sync images to R2
  if: github.ref == "refs/heads/main"
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.R2_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.R2_SECRET_ACCESS_KEY }}
    AWS_DEFAULT_REGION: auto
    R2_ENDPOINT_URL: ${{ secrets.R2_ENDPOINT_URL }}
  run: |
    aws s3 sync assets/images s3://tecmah-blog/assets/images \
      --endpoint-url "$R2_ENDPOINT_URL" \
      --no-progress --size-only \
      --cache-control "public, max-age=31536000, immutable"

- name: Set cdn_base for production
  if: github.ref == "refs/heads/main"
  run: |
    echo "cdn_base: ${{ secrets.CDN_BASE }}" > _config.prod.yml
- run: bundle exec jekyll build --trace --config _config.yml,_config.prod.yml
```

### 受け入れ条件
- main push で画像が同期
- 本番サイトの画像 URL が CDN ベース

### 注意点
- CDN キャッシュの伝播に時間がかかる場合あり
EOF
}

body_10() {
cat <<'EOF'
### 概要
既存 `assets/images/` を R2/S3 へ同期し、`cdn_base` だけで参照先を切替。必要ならリポから除外。

### 手順
```bash
# 一括同期（R2例）
aws s3 sync assets/images/ s3://tecmah-blog/assets/images/ \
  --endpoint-url https://<accountid>.r2.cloudflarestorage.com \
  --no-progress --size-only \
  --cache-control "public, max-age=31536000, immutable"

# 動作確認後、リポから画像を外す案（安全のため別ブランチで）
# git rm -r assets/images
# echo "assets/images/" >> .gitignore
# git add .gitignore
# git commit -m "Use CDN-hosted images; stop tracking local images"
```

（任意）履歴軽量化は後日 `git filter-repo`（破壊的変更に注意）。

### 受け入れ条件
- すべての画像が CDN 配信で表示
- （任意）リポサイズ縮小

### 注意点
- しばらく両持ち運用も可
EOF
}

# =========================
# Create Issues
# =========================

create_issue "01: _site をGit追跡から外し、CIで生成する体制に切替える" "infra,jekyll,good first issue" body_01
create_issue "02: GitHub Pages への自動デプロイWorkflowを追加" "ci,jekyll" body_02
create_issue "03: 画像をGit LFSで管理（最初のステップ）" "lfs,assets" body_03
create_issue "04: 画像参照をテンプレ化（cdn_base切替 & _includes/picture.html導入）" "template,assets" body_04
create_issue "05: 画像登録を自動化する bin/add-image（最適化→配置→WebP→スニペット出力）" "automation,assets" body_05
create_issue "06: 記事ひな型Rakeタスク（スラグと画像ディレクトリ自動作成）" "automation,content" body_06
create_issue "07: HTMLProofer をCIに導入（リンク/画像検証）" "ci,quality" body_07
create_issue "08: R2/S3 バケットとCDNを用意（本番配信の土台）" "infra,cdn" body_08
create_issue "09: CIで画像をR2/S3へ同期し、本番でcdn_baseを有効化" "ci,cdn,assets" body_09
create_issue "10: 既存画像の一括移行（R2/S3へ同期＆リポからの除外検討）" "migration,cdn,assets" body_10

echo "[DONE] Issues creation finished."
