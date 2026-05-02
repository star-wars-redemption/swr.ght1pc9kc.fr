
themes/binario/node_modules:
	cd themes/binario && \
		npm ci --unsafe-perm

serve: themes/binario/node_modules
	docker run -u $(shell id -u):$(shell id -g) -it --rm -p 1313:1313 -v "$$PWD:/src" \
		hugomods/hugo:base-0.145.0 \
		hugo server --buildFuture --buildDrafts --bind 0.0.0.0

pages: themes/binario/node_modules
	hugo --minify -b $$CF_PAGES_URL

clean:
	rm -rf themes/binario/node_modules
	rm -rf public
	rm -rf resources/_gen

list:
	make -npq : 2> /dev/null | awk -v RS= -F: '$$1 ~ /^[^#%.]+$$/ { print $$1 }' | sort -u
