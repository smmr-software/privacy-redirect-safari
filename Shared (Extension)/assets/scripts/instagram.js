"use strict";

const reservedPaths = new Set([
  "about",
  "explore",
  "support",
  "press",
  "api",
  "privacy",
  "safety",
  "admin",
  "graphql",
  "accounts",
  "help",
  "terms",
  "contact",
  "blog",
  "igtv",
  "u",
  "p",
  "fragment",
  "imageproxy",
  "videoproxy",
  ".well-known",
  "tv",
  "reel",
]);

browser.runtime.sendMessage({ type: "redirectSettings" })
  .then((redirects) => {
    if (redirects.bibliogram) {
      return browser.runtime.sendMessage({ type: "instanceSettings" });
    } else {
      return null;
    }
  })
  .then((instances) => {
    if (instances) {
      const url = new URL(window.location);

      if (url.pathname.match(/login/)) {
        const nextPathname = url.searchParams.get("next");
        if (!nextPathname) return;
        url.pathname = nextPathname;
        url.searchParams.delete("next");
      }

      if (!url.pathname.match(/accounts/)) {
        const paths = url.pathname.split("/");
        const isUser = url.pathname !== "/" && !reservedPaths.has(paths[1]);
        const isUserPrefixed = isUser && paths[2] &&
          reservedPaths.has(paths[2]);

        let instance = instances.bibliogram;
        if (
          !instance.startsWith("http://") &&
          !instance.startsWith("https://")
        ) {
          instance = "https://" + instance;
        }

        const redirect = `${instance}${isUser && !isUserPrefixed ? "/u" : ""}${
          isUserPrefixed ? `/${paths.slice(2).join("/")}` : url.pathname
        }${url.search}`;

        console.info(`Redirecting ${window.location.href} => ${redirect}`);
        if (window.location.href !== redirect) {
          window.location = redirect;
        }
      }
    }
  });
