// ==UserScript==
// @name         B4J button
// @version      0.1
// @description  Add a button on playdata page to register playdata to b4j
// @author       OmeletWithoutEgg
// @match        *://p.eagate.573.jp/game/jubeat/beyond/playdata/index.html
// ==/UserScript==

function score_regist() {
  const url = 'https://b4j-beyond.mono-logic.com/score_regist.js'; 
  const element = document.createElement('script');
  element.src = url;
  document.getElementsByTagName('head')[0].appendChild(element);
  // TODO if pressed no, then this element should be removed?
}

function add_button() {
  const button = document.createElement('button');
  button.className = 'link-btn';
  button.textContent = 'B4J bt Ave. にスコア登録・更新';
  button.onclick = score_regist;
  document.getElementsByClassName('frame score')[0].appendChild(button);
}
add_button();
