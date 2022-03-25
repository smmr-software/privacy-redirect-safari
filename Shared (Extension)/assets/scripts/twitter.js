"use strict";

function redirectTwitter(instance, url) {
  if (url.host.split(".")[0] === "pbs") {
    return `${instance}/pic/${encodeURIComponent(url.href)}`;
  } else if (url.host.split(".")[0] === "video") {
    return `${instance}/gif/${encodeURIComponent(url.href)}`;
  } else {
    return `${instance}${url.pathname}${url.search}`;
  }
}

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.nitter) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    navigator.serviceWorker.getRegistrations().then((registrations) => {
      for (const registration of registrations) {
        if (registration.scope === "https://twitter.com/") {
          registration.unregister();
          console.log("Unregistered Twitter SW", registration);
        }
      }
    });
    if (instances) {
      const url = new URL(window.location);
      if (!url.pathname.includes("/home")) {
        let instance = instances.nitter;
        if (
          !instance.startsWith("http://") &&
          !instance.startsWith("https://")
        ) {
          instance = "https://" + instance;
        }

        const redirect = redirectTwitter(instance, url);
        console.info(`Redirecting ${url.href} => ${redirect}`);
        if (url.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
