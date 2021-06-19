"use strict";

const redditInstances = [
  // libreddit: privacy w/ modern UI
  "https://libredd.it",
  "https://libreddit.spike.codes",
  "https://libreddit.kavin.rocks",
  "https://libreddit.insanity.wtf",
  "https://libreddit.dothq.co",
  "https://libreddit.silkky.cloud",
  "https://libreddit.himiko.cloud",
  // teddit: privacy w/ old UI
  "https://teddit.net",
  "https://teddit.ggc-project.de",
  "https://teddit.kavin.rocks",
  "https://old.reddit.com", // desktop
  "https://i.reddit.com", // mobile
  "https://snew.notabug.io", // anti-censorship
];
const bypassPaths = /\/(gallery\/poll\/rpan\/settings\/topics)/;

let disableReddit;
let redditInstance;
let exceptions;

window.browser = window.browser || window.chrome;

function getRandomInstance() {
  return redditInstances[~~(redditInstances.length * Math.random())];
}

function isNotException(url) {
  return !exceptions.some((regex) => regex.test(url.href));
}

function shouldRedirect(url) {
  return (
    isNotException(url) &&
    !disableReddit &&
    !url.pathname.match(bypassPaths)
  );
}

function redirectReddit(url) {
  if (url.host === "i.redd.it") {
    if (redditInstance.includes("libredd")) {
      return `${redditInstance}/img${url.pathname}${url.search}`;
    } else if (redditInstance.includes("teddit")) {
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
  return `${redditInstance}${url.pathname}${url.search}`;
}

browser.storage.sync.get(
  [
    "redditInstance",
    "disableReddit",
    "exceptions",
  ],
  (result) => {
    disableReddit = result.disableReddit;
    redditInstance = result.redditInstance || getRandomInstance();
    exceptions = result.exceptions
      ? result.exceptions.map((e) => {
          return new RegExp(e);
        })
      : [];
    const url = new URL(window.location);
    if (shouldRedirect(url)) {
      const redirect = redirectReddit(url);
      console.info("Redirecting", `"${url.href}"`, "=>", `"${redirect}"`);
      window.location = redirect;
    }
  }
);
