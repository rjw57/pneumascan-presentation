HAML?=ham
OUTDIR:=output

all: figures index.html

${OUTDIR}:
	mkdir -p output

PNGS_FROM_SVGS := $(patsubst %.svg,%.png,$(wildcard figures/*.svg))

figures: ${PNGS_FROM_SVGS}

github: all ${OUTDIR}
	cp index.html slide_config.js "${OUTDIR}"
	cp -r figures/ js/ theme/ "${OUTDIR}"
	ghp-import -n ${OUTDIR}
	git push origin gh-pages:gh-pages

%.png: %.svg
	inkscape -z -C -d 300 "-e=$@" "$<"

%.html: %.html.haml
	haml "$<" >"$@"

.PHONY: all figures github
