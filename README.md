# express monorepo

This setup a monorepo for [express] and all of its dependencies using the monorepo manager [fynpo].

It works by cloning each dependencies from their github repo, and then use [fynpo] to bootstrap them.

After bootstrap, the modules installed for express will be linked to the local copies.

This makes it very convenient to test and experiment with all of [express]' code.

For example, make changes in `expressjs/body-parser` and test them in `expressjs/express` immediately.

## Getting Started

- clone this
- Use node.js 12
- Run `npm run bootstrap`

## Test

Run `npm test` at the top to execute npm script `test` in all packages.

It runs the command `npx fynpo run test --stream`.

## Some notes

Some of the packages' test seem have these issues:

- They fail with node.js beyond version 12.
- They fail occassionaly, but running them again pass.

[fynpo]: https://jchip.github.io/fynpo/
[express]: https://expressjs.com/
