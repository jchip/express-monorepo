mkdir -p expressjs
mkdir -p pillarjs
mkdir -p jshttp
mkdir -p packages

cd expressjs

[ -d express ] || git clone https://github.com/expressjs/express.git
[ -d body-parser ] || git clone https://github.com/expressjs/body-parser
[ -d serve-static ] || git clone https://github.com/expressjs/serve-static.git

cd ../pillarjs

[ -d encodeurl ] || git clone https://github.com/pillarjs/encodeurl.git
[ -d finalhandler ] || git clone https://github.com/pillarjs/finalhandler.git
[ -d parseurl ] || git clone https://github.com/pillarjs/parseurl.git
# [ -d path-to-regexp ] || git clone https://github.com/pillarjs/path-to-regexp.git
[ -d send ] || git clone https://github.com/pillarjs/send.git

cd ../jshttp

[ -d accepts ] || git clone https://github.com/jshttp/accepts.git
[ -d cookie ] || git clone https://github.com/jshttp/cookie.git
[ -d etag ] || git clone https://github.com/jshttp/etag.git
[ -d content-disposition ] || git clone https://github.com/jshttp/content-disposition.git
[ -d content-type ] || git clone https://github.com/jshttp/content-type.git
[ -d fresh ] || git clone https://github.com/jshttp/fresh.git
[ -d methods ] || git clone https://github.com/jshttp/methods.git
[ -d on-finished ] || git clone https://github.com/jshttp/on-finished.git
[ -d proxy-addr ] || git clone https://github.com/jshttp/proxy-addr.git
[ -d range-parser ] || git clone https://github.com/jshttp/range-parser.git
[ -d statuses ] || git clone https://github.com/jshttp/statuses.git
[ -d type-is ] || git clone https://github.com/jshttp/type-is.git
[ -d vary ] || git clone https://github.com/jshttp/vary.git

cd ../packages

# [ -d array-flatten ] || git clone https://github.com/blakeembrey/array-flatten.git
[ -d node-cookie-signature ] || git clone https://github.com/tj/node-cookie-signature.git
[ -d qs ] || git clone https://github.com/ljharb/qs.git
[ -d nodejs-depd ] || git clone https://github.com/dougwilson/nodejs-depd.git
[ -d escape-html ] || git clone https://github.com/component/escape-html.git
[ -d merge-descriptors ] || git clone https://github.com/component/merge-descriptors.git
[ -d safe-buffer ] || git clone https://github.com/feross/safe-buffer.git
[ -d setprototypeof ] || git clone https://github.com/wesleytodd/setprototypeof.git
[ -d utils-merge ] || git clone https://github.com/jaredhanson/utils-merge.git

cd ..
