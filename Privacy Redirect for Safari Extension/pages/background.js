"use strict";

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.type == "Open Sesame") {
    browser.runtime.sendNativeMessage({ message: "Open Sesame" });
  }
})
