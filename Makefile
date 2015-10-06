ci:
	scripts/prepare.js; \
	node-gyp configure; \
	node-gyp rebuild; \
