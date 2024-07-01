# https://pandoc.org/MANUAL.html#slide-shows

SLIDE_OPTIONS=-t revealjs -V theme=solarized --css=./custom.css -s

all: docs/index.html

docs/index.html: slides.md
	pandoc $(SLIDE_OPTIONS) $< -o $@

watch: slides.md
	fswatch -o --event Updated $< | xargs -I{} sh -c "echo Rebuilding...; pandoc $(SLIDE_OPTIONS) $< -o docs/index.html"