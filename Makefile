SOURCES := reply.i.md
TARGETS := reply.md

all: reply.md

clean:
	@rm -f ${TARGETS} ${METAS}

references.qids: findCitations.groovy
	@echo "Finding the citations"
	@groovy findCitations.groovy . | grep "^Q" | sort | uniq > references.qids

references.dat: references.qids references.js references.extra.dat
	@nodejs references.js
	@cat references.extra.dat >> references.dat

%.md : %.i.md createMarkdown.groovy references.dat
	@echo "Creating $@"
	@groovy createMarkdown.groovy $< > $@
