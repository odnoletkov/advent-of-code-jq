JQ := $(wildcard *.jq)
TASK := $(JQ:.jq=)

.PHONY: all
all: $(TASK)

.PHONY: $(TASK)
.SECONDEXPANSION:
$(TASK) : % : $$(subst -1,,$$(subst -2,,$$(subst +,,$$@))).input %.jq
	jq --raw-input --null-input --from-file $@.jq $<

%.input:
	session=$$(security find-generic-password -s adventofcode.com -a me -w) && \
		curl --fail --output $@ --cookie session="$$session" \
			"https://adventofcode.com/2020/day/$(*:0%=%)/input"

.PHONY: save-session
save-session:
	security add-generic-password -U -s adventofcode.com -a me -w
