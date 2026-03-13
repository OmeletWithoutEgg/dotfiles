// ==UserScript==
// @name         Vaddict button
// @version      0.3.0
// @description  Helper buttons on playdata page to register playdata to Vaddict
// @author       OmeletWithoutEgg
// @match        *://p.eagate.573.jp/game/sdvx/vii/playdata/profile/index.html
// ==/UserScript==

async function fetchScoreText() {
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

  return scoreText;
}

async function downloadScoreCsv() {
  const scoreText = await fetchScoreText();

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

function execBookmarklet(url) {
  return function () {
    const element = document.createElement("script");
    element.src = url;
    document.getElementsByTagName("head")[0].appendChild(element);
  };
}

function makeButton(text, onclock) {
  const button = document.createElement("button");
  button.textContent = text;
  button.onclick = onclock;
  button.style = `
    color: white;
    border: 1px solid #8AD004;
    background: linear-gradient(#220022, #555555);
    box-shadow: inset 0 0 5px 0px #8AD004;
    border-radius: 5px;
    padding: 5px;
    margin: 3px;
  `;
  return button;
}

function makeCopyButton() {
  const span = document.createElement("span");
  span.style = `
    position: relative;
    display: inline-block;
  `;
  const status = document.createElement("span");
  status.style = `
    position: absolute;
    left: 100%;
    top: 50%;
    transform: translate(6px, -50%);
    white-space: nowrap;
  `;

  const button = makeButton("CSV スコアデータをコピー", async () => {
    try {
      const scoreText = await fetchScoreText();
      if (!navigator.clipboard || !navigator.clipboard.writeText) {
        throw new Error("clipboard unavailable");
      }
      await navigator.clipboard.writeText(scoreText);
      status.textContent = "コピーしました";
    } catch (err) {
      status.textContent = "ERROR";
    } finally {
      setTimeout(() => {
        status.textContent = "";
      }, 1000);
    }
  });
  span.appendChild(button);
  span.appendChild(status);
  return span;
}

function main() {
  const div = document.createElement("div");
  div.style = "text-align: center;";
  div.appendChild(makeButton(
    "Vaddict に通常スコア登録・更新",
    execBookmarklet("https://vaddict.b35.jp/regist_nabla.js")
  ));
  div.appendChild(makeButton(
    "Vaddict に EX スコア登録・更新",
    execBookmarklet("https://vaddict.b35.jp/regist_nabla2.js")
  ));
  div.appendChild(makeButton(
    "CSV スコアデータをダウンロード",
    downloadScoreCsv
  ));
  div.appendChild(makeCopyButton());

  const playdata = document.getElementById("playdata");
  const profile = playdata.querySelector("#profile");
  profile.insertAdjacentElement("afterend", div);
}

main();
