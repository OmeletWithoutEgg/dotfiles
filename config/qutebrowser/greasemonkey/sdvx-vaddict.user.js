// ==UserScript==
// @name         Vaddict button
// @version      0.1
// @description  Add a button on playdata page to register playdata to Vaddict
// @author       OmeletWithoutEgg
// @match        *://p.eagate.573.jp/game/sdvx/vi/playdata/profile/index.html
// ==/UserScript==

function main() {
  function make_button(text, url) {
    const button = document.createElement('button');
    button.textContent = text;
    button.onclick = function () {
      const element = document.createElement('script');
      element.src = url;
      document.getElementsByTagName('head')[0].appendChild(element);
    };
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
  grade_section.appendChild(make_button(
    'Vaddict に通常スコア登録・更新',
    'https://vaddict.b35.jp/regist.js'
  ));
  grade_section.appendChild(make_button(
    'Vaddict に EX スコア登録・更新',
    'https://vaddict.b35.jp/regist2.js'
  ));
}
main();
