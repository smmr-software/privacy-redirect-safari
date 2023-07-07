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
        let redirect = `${instances.invidious}${
          url.pathname.replace("/shorts", "")
        }${url.search}`;

        if (
          !instances.invidious.startsWith("http://") &&
          !instances.invidious.startsWith("https://") &&
          !instances.invidious.startsWith("yattee://")
        ) {
          redirect = "https://" + redirect;
        }

        console.info(`Redirecting ${url.href} => ${redirect}`);
        if (url.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
