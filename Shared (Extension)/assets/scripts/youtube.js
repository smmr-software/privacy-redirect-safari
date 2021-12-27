"use strict";

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.invidious) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);
      if (
        !(url.pathname.match(/iframe_api/) ||
          url.pathname.match(/www-widgetapi/))
      ) {
        const redirect = `https://${instances.invidious}${
          url.pathname.replace("/shorts", "")
        }${url.search}`;
        console.info(`Redirecting ${url.href} => ${redirect}`);
        if (url.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
