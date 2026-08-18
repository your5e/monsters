.PHONY: clean html lint research serve test

.DEFAULT_GOAL := html

PORT = 6678

research:
	bin/open_research.sh

clean:
	rm -rf build

html: clean
	python bin/build_html.py monsters.toml build

serve:
	@echo
	@echo "** http://localhost:$(PORT)/monsters.html"
	@echo
	python -m http.server $(PORT) --directory build

lint:
	ruff check .

test: lint
	pytest
