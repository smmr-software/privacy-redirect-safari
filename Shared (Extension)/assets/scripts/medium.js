"use strict";

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.scribe) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);
      const redirect =
        `https://${instances.scribe}${url.pathname}${url.search}`;
      console.info(`Redirecting ${url.href} => ${redirect}`);
      if (url.href !== redirect) {
        window.location = redirect;
      }
    }
  });
