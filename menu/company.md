---
layout: page
title: 会社概要
permalink: /company/
---

## 会社情報

<style>
.company-table {
  margin: 2rem 0;
  width: 100%;
  border-collapse: collapse;
}

.company-table th {
  background-color: #f8f9fa;
  text-align: left;
  padding: 1rem;
  width: 30%;
  border-bottom: 2px solid #dee2e6;
}

.company-table td {
  padding: 1rem;
  border-bottom: 1px solid #dee2e6;
}

.profile-section {
  margin-top: 3rem;
}

.profile-section h2 {
  margin-bottom: 2rem;
}

.mission-section {
  background-color: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
  margin: 3rem 0;
  text-align: center;
}

.values-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.value-item {
  text-align: center;
}

.value-item h4 {
  color: #007bff;
  margin-bottom: 0.5rem;
}

.contact-info {
  color: #007bff;
  font-weight: bold;
}
</style>

<script>
function showContact(type) {
  // シンプルな数学CAPTCHA
  const num1 = Math.floor(Math.random() * 10) + 1;
  const num2 = Math.floor(Math.random() * 10) + 1;
  const answer = num1 + num2;
  
  const userAnswer = prompt(`${num1} + ${num2} = ? を計算してください:`);
  
  if (userAnswer && parseInt(userAnswer) === answer) {
    const contactData = {
      'phone': '070-8359-2530',
      'email': 'info.tecmah@gmail.com',
      'address': '北海道札幌市中央区南2条西5丁目31-1RMBld.701'
    };
    
    const element = document.getElementById(type);
    if (element) {
      element.innerHTML = contactData[type];
      element.className = 'contact-info';
      element.onclick = null;
      element.style.cursor = 'default';
    }
  } else {
    alert('計算が間違っています。もう一度お試しください。');
  }
}
</script>

<table class="company-table">
  <tr>
    <th>会社名</th>
    <td>株式会社TECMAH</td>
  </tr>
  <tr>
    <th>代表者</th>
    <td>松浦 賢孝</td>
  </tr>
  <tr>
    <th>住所</th>
    <td><span id="address" style="cursor: pointer;" onclick="showContact('address')">[クリックして表示]</span>
</td>
  </tr>
  <tr>
    <th>連絡先</th>
    <td>
      TEL: <span id="phone" style="cursor: pointer;" onclick="showContact('phone')">[クリックして表示]</span><br>
      Email: <span id="email" style="cursor: pointer;" onclick="showContact('email')">[クリックして表示]</span>
    </td>
  </tr>
  <tr>
    <th>設立</th>
    <td>2019年7月（フリーランスとして活動開始）<br>
        2025年7月（法人設立）
    </td>
  </tr>
  <tr>
    <th>事業内容</th>
    <td>
      ・AI開発・データ解析<br>
      ・システム開発・プロジェクトマネジメント<br>
      ・M&A支援プラットフォーム運営<br>
      ・リスキリング・教育事業
    </td>
  </tr>
</table>

<div class="profile-section">
  <h2>代表者プロフィール</h2>
  
  <p>
    AI技術を活用した新規事業開発やPdM/AEとしてのプロジェクト推進に強みを持ち、<strong>技術とビジネスの両面から成果を生み出せる</strong>人材です。
  </p>
  
  <p>
    <strong>システム開発の全工程を見通せる</strong>だけでなく、Azure AIやOpenAI、RAGを活用したクラウドネイティブ開発やデータ解析を活かし、業務効率化やプロダクトの価値向上に貢献してきました。
  </p>
  
  <h3>主な経歴</h3>
  <ul>
    <li><strong>2025年</strong>：株式会社ripla - AIを活用した教育プロダクトのPM/SE</li>
    <li><strong>2025年</strong>：株式会社Hmcomm - 音声データ解析による異常検知PM/SE</li>
    <li><strong>2024年</strong>：株式会社Sapeet - インタラクティブミラー開発PdM/AE</li>
    <li><strong>2023年</strong>：株式会社Algoage - AI新規事業創出PdM</li>
    <li><strong>2021年</strong>：複数のスタートアップでPM/PMOとして活動</li>
  </ul>
  
  <h3>技術スキル</h3>
  <ul>
    <li><strong>プログラミング言語</strong>：Python, Ruby, Rails, Swift, C#, Java, PHP, SQL</li>
    <li><strong>AI・クラウド技術</strong>：Azure AI, OpenAI, RAG, AWS, Google Cloud</li>
    <li><strong>プロジェクト管理</strong>：アジャイル開発、スクラム、オフショア開発管理</li>
  </ul>
</div>

<div class="mission-section">
  <h2>企業理念</h2>
  
  <h3>ミッション</h3>
  <p>「新たな事業価値を創造し、M&Aによって社会的な成長を牽引する」</p>
  
  <h3>バリュー</h3>
  <div class="values-grid">
    <div class="value-item">
      <h4>イノベーション</h4>
      <p>最先端技術を駆使し、企業の課題を解決する</p>
    </div>
    <div class="value-item">
      <h4>スピード</h4>
      <p>効率的な成長で早期収益化を実現する</p>
    </div>
    <div class="value-item">
      <h4>信頼</h4>
      <p>企業の成長とエグジットの達成まで伴走する</p>
    </div>
  </div>
</div> 