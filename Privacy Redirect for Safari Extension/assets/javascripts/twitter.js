"use strict";

function redirectTwitter(instance, url) {
  if (url.host.split(".")[0] === "pbs") {
    return `https://${instance}/pic/${encodeURIComponent(url.href)}`;
  } else if (url.host.split(".")[0] === "video") {
    return `https://${instance}/gif/${encodeURIComponent(url.href)}`;
  } else {
    return `https://${instance}${url.pathname}${url.search}`;
  }
}

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then(redirects => {
    if (redirects.nitter) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then(instances => {
    navigator.serviceWorker.getRegistrations().then((registrations) => {
      for (let registration of registrations) {
        if (registration.scope === "https://twitter.com/") {
          registration.unregister();
          console.log("Unregistered Twitter SW", registration);
        }
      }
    });
    if (instances) {
      const url = new URL(window.location);
      if (!url.pathname.includes("/home")) {
        const redirect = redirectTwitter(instances.nitter, url);
        console.info(`Redirecting ${url.href} => ${redirect}`);
        window.location = redirect;
      }
    }
  });
