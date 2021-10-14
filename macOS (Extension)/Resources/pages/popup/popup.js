"use strict";

document.querySelector("#open").addEventListener("click", () => {
  browser.runtime.sendMessage({type: "Open Sesame"});
});
