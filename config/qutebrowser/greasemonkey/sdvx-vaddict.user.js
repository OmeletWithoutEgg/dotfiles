// ==UserScript==
// @name         Vaddict button
// @version      0.2.0
// @description  Helper buttons on playdata page to register playdata to Vaddict
// @author       OmeletWithoutEgg
// @match        *://p.eagate.573.jp/game/sdvx/vii/playdata/profile/index.html
// ==/UserScript==

async function downloadScoreCsv() {
  const url = "/game/sdvx/vii/playdata/download/index.html";
  const form = new URLSearchParams({ method: "display" });

  const res = await fetch(url, {
    method: "POST",
    credentials: "include",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    },
    body: form.toString(),
  });

  if (!res.ok) {
    throw new Error(`fetch failed: HTTP ${res.status}`);
  }

  const html = await res.text();
  const doc = new DOMParser().parseFromString(html, "text/html");
  const scoreEl = doc.querySelector("#score_data");
  const scoreText = (scoreEl && ("value" in scoreEl ? scoreEl.value : scoreEl.textContent)) || "";

  if (!scoreText.trim()) {
    throw new Error("score_data not found");
  }

  const d = new Date();
  const ymd =
    d.getFullYear().toString() +
    String(d.getMonth() + 1).padStart(2, "0") +
    String(d.getDate()).padStart(2, "0");

  const filename = `score-${ymd}.csv`;
  const bom = new Uint8Array([0xef, 0xbb, 0xbf]);
  const blob = new Blob([bom, scoreText], { type: "text/csv;charset=utf-8" });

  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(a.href), 1000);

  return filename;
}

function main() {

  function scriptCallback(url) {
    return function () {
      const element = document.createElement('script');
      element.src = url;
      document.getElementsByTagName('head')[0].appendChild(element);
    };
  }

  function makeButton(text, callback) {
    const button = document.createElement('button');
    button.textContent = text;
    button.onclick = callback;
    button.style = `
    color: white;
    border: 1px solid #00ffff;
    background: linear-gradient(#220022, #555555);
    box-shadow: inset 0 0 5px 0px #00ffff; // , 0 0 0 5px #220022, 0 0 0 6px #555555;
    border-radius: 5px;
    padding: 5px;
    margin: 20px;
    `;

    return button;
  }

  const grade_section = document.getElementById('Effect_Level');
  grade_section.appendChild(makeButton(
    'Vaddict に通常スコア登録・更新',
    scriptCallback('https://vaddict.b35.jp/regist_nabla.js')
  ));
  grade_section.appendChild(makeButton(
    'Vaddict に EX スコア登録・更新',
    scriptCallback('https://vaddict.b35.jp/regist_nabla2.js')
  ));
  grade_section.appendChild(makeButton(
    'CSV スコアデータをダウンロード',
    downloadScoreCsv
  ));
}

main();
