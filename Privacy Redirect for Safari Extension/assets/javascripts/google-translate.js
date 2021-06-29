"use strict";

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then(redirects => {
    if (redirects.simplyTranslate) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then(instances => {
    if (instances) {
      const url = new URL(window.location);
      const redirect = `https://${instances.simplyTranslate}/${url.search}`;
      console.info(`Redirecting ${url.href} => ${redirect}`);
      window.location = redirect;
    }
  });
