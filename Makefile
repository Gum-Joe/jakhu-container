ci:
	diff -u src/exec.h src/execlin.h > exec.patch; \
	patch src/exec.h < exec.patch; \
	node-gyp configure; \
	node-gyp rebuild; \
	@echo Done!;
