"use strict";

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.type == "redirectSettings") {
    browser.runtime.sendNativeMessage("application.id", { message: "redirectSettings" }, function(response) {
      sendResponse(response);
    });
    return true;
  } else if (request.type == "instanceSettings") {
    browser.runtime.sendNativeMessage("application.id", { message: "instanceSettings" }, function(response) {
      sendResponse(response);
    });
    return true;
  }
})
