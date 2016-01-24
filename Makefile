# Make file for compile
SRCDIR := src
COFFEEC ?= coffee
OUT ?= libs
SRCS := $(shell  find ./src -name "*.coffee")
JS := $(patsubst %.coffee, %.js, $(patsubst ./src, $(OUT), $(SRCS)))
JSR := $(subst ./src, $(OUT), $(JS))

all: $(JSR)
	@make $(JSR);

watch:
	@mkdir -p libs
	$(COFFEEC) --watch -o $(OUT) -c $(SRCDIR)

libs/%.js: src/%.coffee
	@echo "  COFFEEC(compile) "$@
	@$(COFFEEC) -o $@ -c $<
