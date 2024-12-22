---
layout: post
title: The Frameworks of Effective Product Design Sense
subtitle: Craft products better with better systematic design judgment
description:
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
image: "/assets/images/newbusinessflowchart/pro.png)"
category:
- Engineering
tags:
- SQL
---


今回は前回のSQLの記事の続きで具体的なSQLの練習問題を用意しました。

以下の問題に取り組んでみてください。各問題で、どのようなクエリを書けばよいかを考えながら、実際に手を動かしてみてください。

### テーブル情報
まずは、練習用の `employees` テーブルを想定してみましょう。以下のような構造です。

| id  | name      | department | age | salary |
|-----|-----------|------------|-----|--------|
| 1   | 田中 太郎 | Sales      | 30  | 500000 |
| 2   | 佐藤 花子 | HR         | 25  | 400000 |
| 3   | 鈴木 次郎 | Engineering| 35  | 700000 |
| 4   | 高橋 三郎 | Sales      | 40  | 600000 |
| 5   | 伊藤 あき | HR         | 28  | 450000 |
| 6   | 小林 一郎 | Engineering| 32  | 650000 |

### 練習問題

#### 問題1: 全ての社員の名前と年齢を取得する
`employees` テーブルから、全ての社員の `name` と `age` を取得するクエリを書いてください。

#### 問題2: 年齢が30歳以上の社員を取得する
年齢が30歳以上の社員の `name`, `age`, `department` を取得するクエリを書いてください。

#### 問題3: Sales部門に所属する社員を取得する
`Sales` 部門に所属する全社員の `name` と `salary` を取得してください。

#### 問題4: 給料の高い順に社員の名前と給料を並び替える
全ての社員の `name` と `salary` を、給料が高い順に並び替えて取得するクエリを書いてください。

#### 問題5: 部門ごとの平均給料を計算する
各部門の平均給料を計算し、それぞれの `department` と平均給料を取得するクエリを書いてください。

#### 問題6: 給料が600000以上の社員の数をカウントする
給料が600,000円以上の社員が何人いるかをカウントするクエリを書いてください。

#### 問題7: Engineering部門で最も若い社員を取得する
`Engineering` 部門で最も若い社員の `name` と `age` を取得するクエリを書いてください。

---

### 解答例

以下に、それぞれの問題に対する解答例を示します。自分でクエリを書いてみた後、参考にしてみてください。

#### 問題1 解答例:
```sql
SELECT name, age FROM employees;
```

#### 問題2 解答例:
```sql
SELECT name, age, department FROM employees WHERE age >= 30;
```

#### 問題3 解答例:
```sql
SELECT name, salary FROM employees WHERE department = 'Sales';
```

#### 問題4 解答例:
```sql
SELECT name, salary FROM employees ORDER BY salary DESC;
```

#### 問題5 解答例:
```sql
SELECT department, AVG(salary) FROM employees GROUP BY department;
```

#### 問題6 解答例:
```sql
SELECT COUNT(*) FROM employees WHERE salary >= 600000;
```

#### 問題7 解答例:
```sql
SELECT name, age FROM employees WHERE department = 'Engineering' ORDER BY age ASC LIMIT 1;
```

---

このように、問題に対して自分でクエリを考えてみることが非常に重要です。理解が深まるだけでなく、実際にクエリを書く力が身につきます。もし何か不明点や追加の練習問題があれば、気軽に質問してください！