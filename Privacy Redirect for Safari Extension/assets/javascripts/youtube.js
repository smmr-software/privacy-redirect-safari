"use strict";

const invidiousInstances = [
  "https://invidious.snopyta.org",
  "https://invidious.xyz",
  "https://invidious.kavin.rocks",
  "https://tube.connect.cafe",
  "https://invidious.zapashcanon.fr",
  "https://invidiou.site",
  "https://vid.mint.lgbt",
  "https://invidious.site",
  "https://yewtu.be",
  "https://invidious.tube",
  "https://invidious.silkky.cloud",
  "https://invidious.fdn.fr",
  "https://invidious.himiko.cloud",
  "https://inv.skyn3t.in",
  "https://tube.incognet.io",
  "https://invidious.tinfoil-hat.net",
  "https://invidious.namazso.eu",
  "https://vid.puffyan.us",
  "https://dev.viewtube.io",
  "https://invidious.048596.xyz",
];

let disableInvidious;
let invidiousInstance;
let useFreeTube;
let alwaysProxy;
let videoQuality;
let darkMode;
let volume;
let playerStyle;
let subtitles;
let autoplay;
let exceptions;

window.browser = window.browser || window.chrome;

function getRandomInstance() {
  return invidiousInstances[~~(invidiousInstances.length * Math.random())];
}

function isNotException(url) {
  return !exceptions.some((regex) => regex.test(url.href));
}

function shouldRedirect(url) {
  return (
    isNotException(url) &&
    !disableInvidious &&
    url.host !== invidiousInstance &&
    !(
      url.pathname.match(/iframe_api/) ||
      url.pathname.match(/www-widgetapi/)
    ) &&
    url.host.split(".")[0] !== "studio"
  );
}

function redirectYouTube(url) {
  if (useFreeTube) {
    return `freetube://${url}`;
  }
  if (alwaysProxy) {
    url.searchParams.append("local", true);
  }
  if (videoQuality) {
    url.searchParams.append("quality", videoQuality);
  }
  if (darkMode) {
    url.searchParams.append("dark_mode", darkMode);
  }
  if (volume) {
    url.searchParams.append("volume", volume);
  }
  if (playerStyle) {
    url.searchParams.append("player_style", playerStyle);
  }
  if (subtitles) {
    url.searchParams.append("subtitles", subtitles);
  }
  url.searchParams.append("autoplay", autoplay ? 1 : 0);
  return `${
    invidiousInstance || commonHelper.getRandomInstance(invidiousRandomPool)
  }${url.pathname.replace("/shorts", "")}${url.search}`;
}

browser.storage.sync.get(
  [
    "disableInvidious",
    "invidiousInstance",
    "useFreeTube",
    "alwaysProxy",
    "videoQuality",
    "invidiousDarkMode",
    "invidiousVolume",
    "invidiousPlayerStyle",
    "invidiousSubtitles",
    "invidiousAutoplay",
    "exceptions",
  ],
  (result) => {
    disableInvidious = result.disableInvidious;
    invidiousInstance = result.invidiousInstance || getRandomInstance();
    useFreeTube = result.useFreeTube;
    alwaysProxy = result.alwaysProxy;
    videoQuality = result.videoQuality;
    darkMode = result.invidiousDarkMode;
    volume = result.invidiousVolume;
    playerStyle = result.invidiousPlayerStyle;
    subtitles = result.invidiousSubtitles || "";
    autoplay = result.invidiousAutoplay;
    exceptions = result.exceptions
      ? result.exceptions.map((e) => {
          return new RegExp(e);
        })
      : [];
    const url = new URL(window.location);
    if (shouldRedirect(url)) {
      const redirect = redirectYouTube(url);
      console.info("Redirecting", `"${url.href}"`, "=>", `"${redirect}"`);
      window.location = redirect;
    }
  }
);
