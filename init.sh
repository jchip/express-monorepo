#!/bin/sh
#
# Clone express and its dependencies from their own repos.
#
# Grouped by github org, which is also how fynpo's `packages` globs find them.
# The list tracks express 5's dependencies - see README.md.
#

set -e

mkdir -p expressjs pillarjs jshttp packages

clone() {
  dir="$1/$(basename "$2" .git)"
  [ -d "$dir" ] || git clone "$2" "$dir"
}

#
# Same, but check out a specific release.
#
# Most of these repos work fine at their default branch, and that is the point - you get
# express running against the tip of its dependencies. A few cannot, for two reasons:
#
#   1. The default branch has moved past the range express 5 asks for. fyn will not link
#      a local copy that does not satisfy the range - it quietly installs from the
#      registry instead, and you end up editing a clone nothing uses.
#
#   2. The default branch carries unreleased breaking changes under an unbumped version.
#      type-is is the live example: its master changed the module's export shape while
#      still calling itself 2.1.0, so body-parser's `typeis(...)` call throws
#      "typeis is not a function" and ~220 express tests fail. The version check cannot
#      catch this - only pinning to the released tag can.
#
# Revisit these when express bumps its ranges, or when these repos cut a release.
#
clone_at() {
  dir="$1/$(basename "$2" .git)"
  if [ ! -d "$dir" ]; then
    git clone "$2" "$dir"
    git -C "$dir" checkout -b "poc-$3" "$3"
  fi
}

clone expressjs https://github.com/expressjs/express.git
clone expressjs https://github.com/expressjs/body-parser.git
clone expressjs https://github.com/expressjs/serve-static.git

clone pillarjs https://github.com/pillarjs/encodeurl.git
clone pillarjs https://github.com/pillarjs/finalhandler.git
clone pillarjs https://github.com/pillarjs/parseurl.git
clone pillarjs https://github.com/pillarjs/router.git
clone pillarjs https://github.com/pillarjs/send.git

clone jshttp https://github.com/jshttp/accepts.git
clone_at jshttp https://github.com/jshttp/content-disposition.git v2.0.1
clone_at jshttp https://github.com/jshttp/content-type.git v2.1.0
clone_at jshttp https://github.com/jshttp/cookie.git v0.7.2
clone jshttp https://github.com/jshttp/etag.git
clone jshttp https://github.com/jshttp/fresh.git
clone jshttp https://github.com/jshttp/http-errors.git
clone jshttp https://github.com/jshttp/mime-types.git
clone jshttp https://github.com/jshttp/on-finished.git
clone jshttp https://github.com/jshttp/proxy-addr.git
clone jshttp https://github.com/jshttp/range-parser.git
clone jshttp https://github.com/jshttp/statuses.git
clone_at jshttp https://github.com/jshttp/type-is.git v2.1.0
clone jshttp https://github.com/jshttp/vary.git

clone packages https://github.com/component/escape-html.git
clone packages https://github.com/component/merge-descriptors.git
clone packages https://github.com/dougwilson/nodejs-depd.git
clone packages https://github.com/ljharb/qs.git
clone packages https://github.com/tj/node-cookie-signature.git

#
# Local files the clones cannot commit.
#
# content-disposition and content-type run `prettier --check` in their test script.
# It trips on the fyn-lock.yaml that fyn generates, so tell prettier to skip it.
#
for dir in jshttp/content-disposition jshttp/content-type; do
  echo "fyn-lock.yaml" > "$dir/.prettierignore"
done
