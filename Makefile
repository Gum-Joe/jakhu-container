ci:
	cake install; \
	cake test; \
	mkdir -p instances/test; \
	echo "Prepareing to test..."; \
	echo 'name: test' >> instance/test/.web.yml; \
	echo "Testing..."; \
	mocha
	echo Done!;
