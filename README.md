# Privacy Redirect for Safari

A web extension that redirects Twitter, YouTube, Instagram, Google
Maps, Reddit, Google Search, & Google Translate requests to privacy
friendly alternatives like [Nitter], [Invidious], [FreeTube],
[Bibliogram], [OpenStreetMap], [SimplyTranslate] & Private Search
Engines like [DuckDuckGo] and [Startpage].

It's possible to toggle all redirects on and off. The extension will
default to using random instances if none are selected. If these
instances are not working, you can try and set a custom instance from
the list below, or add your own.

A fork of Simon Brazell's [Privacy Redirect][fork] for Chrome, Edge,
and Firefox.

### Custom instances

Privacy Redirect allows setting custom instances. Some instances can
be found here:

- [Nitter instances](https://github.com/zedeus/nitter/wiki/Instances)
- [Invidious instances](https://docs.invidious.io/Invidious-Instances.md)
- [Bibliogram instances](https://git.sr.ht/~cadence/bibliogram-docs/tree/master/docs/Instances.md)
- [SimplyTranslate instances](https://git.sr.ht/~metalune/simplytranslate_web#list-of-instances)
- [OpenStreetMap tile servers](https://wiki.openstreetmap.org/wiki/Tile_servers)
- Reddit alternatives:
  - [Libreddit](https://github.com/spikecodes/libreddit#instances)
  - [Teddit](https://codeberg.org/teddit/teddit#instances)
  - [Snew](https://github.com/snew/snew)
  - [Old Reddit](https://old.reddit.com) & [Mobile Reddit](https://i.reddit.com),
    purported to be more privacy respecting than the new UI.
- Google Search alternatives:
  - [SearX](https://searx.github.io/searx/)
  - [DuckDuckGo](https://duckduckgo.com)
  - [Startpage](https://startpage.com)
  - [Ecosia](https://www.ecosia.org)
  - [Qwant](https://www.qwant.com)
  - [Mojeek](https://www.mojeek.com)
  - [Presearch](https://www.presearch.org)
  - [Whoogle](https://benbusby.com/projects/whoogle-search/)

## License

[GPLv3](COPYING).

## Permissions

Please note, access to all website navigation events (all URLs), not
just the target domains, is required to allow embedded video redirects
to occur. At this time I know of no other way to achieve iframe
redirects, happy to hear some suggestions on this though 🙂

## Privacy Policy

See the [Project Wiki](https://github.com/SimonBrazell/privacy-redirect/wiki/Privacy-Policy).

[Nitter]: https://github.com/zedeus/nitter
[Invidious]: https://github.com/iv-org/invidious
[FreeTube]: https://github.com/FreeTubeApp/FreeTube
[Bibliogram]: https://sr.ht/~cadence/bibliogram/
[OpenStreetMap]: https://www.openstreetmap.org
[SimplyTranslate]: https://git.sr.ht/~metalune/simplytranslate_web
[DuckDuckGo]: https://duckduckgo.com
[Startpage]: https://startpage.com
[fork]: https://github.com/SimonBrazell/privacy-redirect
