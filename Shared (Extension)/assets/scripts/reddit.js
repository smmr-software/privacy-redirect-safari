"use strict";

const bypassPaths = /\/(gallery\/poll\/rpan\/settings\/topics)/;

function redirectReddit(instance, url) {
  if (url.host === "i.redd.it") {
    if (instance.includes("libredd")) {
      return `https://${instance}/img${url.pathname}${url.search}`;
    } else if (instance.includes("teddit")) {
      // As of 2021-04-09, redirects for teddit images are nontrivial:
      // - navigating to the image before ever navigating to its page causes
      //   404 error (probably needs fix on teddit project)
      // - some image links on teddit are very different
      // Therefore, don't support redirecting image links for teddit.
      return null;
    } else {
      return null;
    }
  }
  return `https://${instance}${url.pathname}${url.search}`;
}

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.reddit) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);
      if (!url.pathname.match(bypassPaths)) {
        const redirect = redirectReddit(instances.reddit, url);
        console.info(`Redirecting ${url.href} => ${redirect}`);
        if (url.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
