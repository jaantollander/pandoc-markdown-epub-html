download-csl:
	./build.sh download_csl

epub:
	./build.sh epub

html:
	./build.sh html

all: epub html

clean:
	./build.sh clean
