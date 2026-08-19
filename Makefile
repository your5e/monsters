.PHONY: clean clean-image html image lint pdf render research serve test

.DEFAULT_GOAL := html

DIR = $(CURDIR)/build
PORT = 6678

research:
	bin/open_research.sh

clean:
	rm -rf build

clean-image:
	docker image prune --all --force --filter label=project=your5e-monsters

html: clean
	python bin/build_html.py monsters.toml build

image:
	docker build -t your5e-monsters .

render: image
	docker run --rm \
		--volume "$(DIR)/assets:/assets" \
		--volume "$(DIR)/images:/images" \
		--volume "$(DIR):/work" \
		your5e-monsters \
		weasyprint /work/monsters.html /work/monsters.pdf

pdf: html render

serve:
	@echo
	@echo "** http://localhost:$(PORT)/monsters.html"
	@echo
	python -m http.server $(PORT) --directory build

lint:
	ruff check .

test: lint image
	bats tests
