cat:
	cat Makefile

c:
	nim c main.nim

png:
	magick output.ppm output.png

all:
	nim c main.nim
	./main
	magick output.ppm output.png

clean:
	rm -f ./main ./output.ppm ./output.png
