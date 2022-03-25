"use strict";

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.simplyTranslate) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);
      let instance = instances.simplyTranslate;
      if (
        !instance.startsWith("http://") &&
        !instance.startsWith("https://")
      ) {
        instance = "https://" + instance;
      }

      const redirect = `${instance}/${url.search}`;
      console.info(`Redirecting ${url.href} => ${redirect}`);
      if (url.href !== redirect) {
        window.location = redirect;
      }
    }
  });
