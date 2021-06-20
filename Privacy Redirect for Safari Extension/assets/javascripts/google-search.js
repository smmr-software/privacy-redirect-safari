"use strict";

const searchEngineInstances = [
  { link: "https://duckduckgo.com", q: "/" },
  { link: "https://startpage.com", q: "/search/" },
  { link: "https://www.ecosia.org", q: "/search" },
  { link: "https://www.qwant.com", q: "/" },
  { link: "https://www.mojeek.com", q: "/search" },
  { link: "https://search.snopyta.org", q: "/" },
  { link: "https://searx.info", q: "/" },
  { link: "https://searx.be", q: "/" },
  { link: "https://search.disroot.org", q: "/" },
  { link: "https://searx.tuxcloud.net", q: "/" },
  { link: "https://searx.ninja", q: "/" },
  { link: "https://tromland.org/searx", q: "/search" },
  { link: "https://engine.presearch.org", q: "/search" },
  { link: "https://searx.silkky.cloud", q: "/" },
  { link: "https://search.trom.tf", q: "/" },
  { link: "https://whooglesearch.net", q: "/search" },
  { link: "https://whoogle.sdf.org", q: "/search" },
  { link: "https://whoogle.himiko.cloud", q: "/search" },
  { link: "https://whoogle-search.zeet.app", q: "/search" },
];
const googleSearchRegex = /https?:\/\/(((www|maps)\.)?(google\.).*(\/search)|search\.(google\.).*)/;
let disableSearchEngine;
let searchEngineInstance;
let exceptions;

window.browser = window.browser || window.chrome;

function getRandomInstance() {
  return searchEngineInstances[~~(searchEngineInstances.length * Math.random())];
}

function isNotException(url) {
  return !exceptions.some((regex) => regex.test(url.href));
}

function shouldRedirect(url) {
  return (
    isNotException(url) &&
    !disableSearchEngine &&
    url.href.match(googleSearchRegex) &&
    !url.pathname.includes("/sorry")
  );
}

function redirectGoogleSearch(url) {
  let search = "";
  url.search
    .slice(1)
    .split("&")
    .forEach(function (input) {
      if (input.startsWith("q=")) search = input;
    });
  return `${searchEngineInstance.link}${searchEngineInstance.q}?${search}`;
}

browser.storage.sync.get(
  [
    "disableSearchEngine",
    "searchEngineInstance",
    "exceptions",
  ],
  (result) => {
    disableSearchEngine = result.disableSearchEngine;
    searchEngineInstance = result.searchEngineInstance || getRandomInstance();
    exceptions = result.exceptions
      ? result.exceptions.map((e) => {
          return new RegExp(e);
        })
      : [];
    const url = new URL(window.location);
    if (shouldRedirect(url)) {
      const redirect = redirectGoogleSearch(url);
      console.info("Redirecting", `"${url.href}"`, "=>", `"${redirect}"`);
      window.location = redirect;
    }
  }
);
