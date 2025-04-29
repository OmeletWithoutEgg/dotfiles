// ==UserScript==
// @name         B4J button
// @version      0.1
// @description  Add a button on playdata page to register playdata to b4j
// @author       OmeletWithoutEgg
// @match        *://p.eagate.573.jp/game/jubeat/beyond/playdata/index.html
// ==/UserScript==

function main() {
  function make_button(text, url) {
    const button = document.createElement('button');
    button.className = 'link-btn';
    button.textContent = text;
    button.onclick = function () {
      const element = document.createElement('script');
      element.src = url;
      document.getElementsByTagName('head')[0].appendChild(element);
      // TODO if pressed no, then this element should be removed?
    };
    return button;
  }

  const score_section = document.getElementsByClassName('frame score')
  score_section[0].appendChild(make_button(
    'B4J bt Ave. に通常スコア登録・更新',
    'https://b4j-beyond.mono-logic.com/score_regist.js'
  ));
  score_section[1].appendChild(make_button(
    'B4J bt Ave. に HARD MODE スコア登録・更新',
    'https://b4j-beyond.mono-logic.com/score_regist_hard.js'
  ));
}
main();
