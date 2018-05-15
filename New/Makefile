HTML := $(patsubst %.rst,%.html,$(wildcard *.rst))

%.html:	%.rst
	pandoc --eol=lf $< -f rst -t html5 --template vista.html5 -o $@
all: $(HTML)
clean:
	rm *.html
