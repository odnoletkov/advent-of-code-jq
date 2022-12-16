JQ := $(wildcard ????/*.jq)
TASK := $(JQ:.jq=)

.PHONY: all
all: $(TASK)

.PHONY: $(TASK)
.SECONDEXPANSION:
$(TASK) : % : $$(subst -1,,$$(subst -2,,$$(subst +,,$$@))).input %.jq
	jq --raw-input --null-input --from-file $@.jq $<

ADVENT_OF_CODE_SESSION ?= $(shell security find-generic-password -s adventofcode.com -a me -w)

%.input:
	curl --fail --output $@ --cookie session="${ADVENT_OF_CODE_SESSION}" \
		"https://adventofcode.com/$(dir $@)day/$(patsubst 0%,%,$(notdir $*))/input"

%.sample:
	curl "https://adventofcode.com/$(dir $@)day/$(patsubst 0%,%,$(notdir $*))" \
		| xmllint --html --xpath "/html/body/main/article/pre[1]/code/text()" - 2>/dev/null \
		| sed '$${/^$$/d;}' >$@

.PHONY: save-session
save-session:
	security add-generic-password -U -s adventofcode.com -a me -w

POST := $(addsuffix .post,$(JQ))

.PHONY: $(POST)
$(POST):
	@echo "# [JQ](https://github.com/odnoletkov/advent-of-code-jq)"
	@echo
	@sed "s/^/    /" $(@:.post=)

last-post:
	@make $$(ls ????/??-?.jq | sort | tail -n 1).post

today-url:
	@date +"https://adventofcode.com/%Y/day/%-d"

today-text:
	@curl --silent --fail "$$(make today-url)" | pandoc -f html -t plain

stats:
	@find . -name \*.jq | cut -c 3-6 | sort | uniq -c

record:
	@asciinema rec -c 'vim $$(date +%Y/%d.input)' $$(date +%Y/%d.asciinema)
