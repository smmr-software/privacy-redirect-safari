"use strict";

const simplyTranslateInstances = ["https://translate.metalune.xyz"]
let disableSimplyTranslate;
let simplyTranslateInstance;
let exceptions;

window.browser = window.browser || window.chrome;

function getRandomInstance() {
  return simplyTranslateInstances[~~(simplyTranslateInstances.length * Math.random())];
}

function isNotException(url) {
  return !exceptions.some((regex) => regex.test(url.href));
}

function shouldRedirect(url) {
  return (
    isNotException(url) &&
    !disableSimplyTranslate
  );
}

function redirectGoogleTranslate(url) {
  return `${simplyTranslateInstance}/${url.search}`;
}

browser.storage.sync.get(
  [
    "disableSimplyTranslate",
    "simplyTranslateInstance",
    "exceptions",
  ],
  (result) => {
    disableSimplyTranslate = result.disableSimplyTranslate;
    simplyTranslateInstance = result.simplyTranslateInstance || getRandomInstance();
    exceptions = result.exceptions
      ? result.exceptions.map((e) => {
          return new RegExp(e);
        })
      : [];
    const url = new URL(window.location);
    if (shouldRedirect(url)) {
      const redirect = redirectGoogleTranslate(url);
      console.info("Redirecting", `"${url.href}"`, "=>", `"${redirect}"`);
      window.location = redirect;
    }
  }
);
