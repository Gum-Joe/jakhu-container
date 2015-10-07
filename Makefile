ci:
	cake install; \
	cake test; \
	mkdir -p instances/test; \
	echo "Prepareing to test..."; \
	echo 'name: test' >> instance/test/.web.yml; \
	echo "Testing..."; \
	mocha
	istanbul cover _mocha test/**/*.js --reporter=lcovonly -- -R spec && cat coverage/lcov.info | node_modules/.bin/coveralls
	echo Done!;
