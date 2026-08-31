# express monorepo

A monorepo containing [express] 5 and all of its dependencies, each cloned from its own github
repo and linked together by [fynpo].

After bootstrap, the modules express resolves are the local clones, not copies from the registry.
Change something in `jshttp/type-is` and express picks it up on the next run - no publish, no
`npm link`, no reinstall.

## Getting started

Requires node.js `>=22.12.0` and [fyn] + [fynpo]:

```sh
npm install -g fyn fynpo
npm run bootstrap
```

`bootstrap` runs `init.sh` to clone the repos, then `fynpo bootstrap` to install and link them.

## Test

`npm test` runs each package's own `test` script via `fynpo run test --stream`.

To work on express itself:

```sh
cd expressjs/express
npm test
```

## Layout

Packages are grouped by github org, which is also how fynpo's `packages` globs find them:

| Directory | Contents |
|---|---|
| `expressjs/` | express, body-parser, serve-static |
| `pillarjs/` | encodeurl, finalhandler, parseurl, router, send |
| `jshttp/` | accepts, content-disposition, content-type, cookie, etag, fresh, http-errors, mime-types, on-finished, proxy-addr, range-parser, statuses, type-is, vary |
| `packages/` | escape-html, merge-descriptors, depd (nodejs-depd), qs, cookie-signature (node-cookie-signature) |

All of these are gitignored - they are clones, not content of this repo. `npm run nuke-all`
removes them.

Of express 5's 28 dependencies, 26 are linked to local clones. `debug` and `once` are not
cloned - they are general-purpose utilities rather than part of the express family - so they
come from the registry.

## Which branch each clone is on

Most clones sit on their default branch, which is the point: you get express running against the
tip of its dependencies. Four cannot, and `init.sh` checks out a release tag for them instead:

| Package | Pinned to | Why |
|---|---|---|
| `cookie` | `v0.7.2` | default branch is 2.x, past express's `^0.7.1` |
| `content-type` | `v2.1.0` | default branch is 3.x, past express's `^2.0.0` |
| `content-disposition` | `v2.0.1` | default branch is 3.x, past express's `^2.0.1` |
| `type-is` | `v2.1.0` | default branch changed its exports without bumping the version |

The first three matter because fyn will not link a local copy whose version does not satisfy the
dependent's range - it installs from the registry instead, and you end up editing a clone that
nothing uses.

`type-is` is the more interesting one, and the reason to be careful here. Its default branch
still calls itself `2.1.0` while having changed the module's export shape, so the version check
passes and the code is incompatible: body-parser's `typeis(...)` call throws
`typeis is not a function` and around 220 of express's tests fail. A version number cannot catch
that - only pinning to the released tag can.

Revisit these when express bumps its ranges, or when those repos cut a release. To try one at its
tip anyway, just `git checkout master` in its directory and re-run `fynpo bootstrap`.

## Notes

- Express's own suite passes here: 1260 tests, 0 failures.
- Some dependencies pin quite old mocha versions that do not run on the newest node.js - on
  node 26, `parseurl` and `proxy-addr` fail with a `yargs` ESM error before any test runs. That
  is those packages' own dev tooling, not express and not the linking.
- `fynpo run test` stops at the first package whose tests fail, so one such package will hide
  the ones after it.

[fyn]: https://github.com/jchip/fynjs/tree/main/packages/fyn
[fynpo]: https://github.com/jchip/fynjs/tree/main/packages/fynpo
[express]: https://expressjs.com/
