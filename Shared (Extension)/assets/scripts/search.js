"use strict";

function redirectSearch(instance, url) {
  let search = "";
  url.search
    .slice(1)
    .split("&")
    .forEach(function (input) {
      if (input.startsWith("q=")) search = input;
    });
  return `${instance}?${search}`;
}

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.searchEngine) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);
      if (!url.pathname.includes("/sorry")) {
        let instance = instances.searchEngine;
        if (
          !instance.startsWith("http://") &&
          !instance.startsWith("https://")
        ) {
          instance = "https://" + instance;
        }

        const redirect = redirectSearch(instance, url);
        console.info(`Redirecting ${url.href} => ${redirect}`);
        if (url.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
