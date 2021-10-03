"use strict";

function redirectGoogleSearch(instance, url) {
  let search = "";
  url.search
    .slice(1)
    .split("&")
    .forEach(function (input) {
      if (input.startsWith("q=")) search = input;
    });
  return `https://${instance}?${search}`;
}

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then(redirects => {
    if (redirects.searchEngine) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then(instances => {
    if (instances) {
      const url = new URL(window.location);
      if (!url.pathname.includes("/sorry")) {
        const redirect = redirectGoogleSearch(instances.searchEngine, url);
        console.info(`Redirecting ${url.href} => ${redirect}`);
        window.location = redirect;
      }
    }
  });
