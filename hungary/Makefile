cat:
	cat Makefile

c:
	nim c main.nim

png:
	convert output.ppm output.png

all:
	nim c main.nim
	./main
	convert output.ppm output.png

clean:
	rm -f ./main ./output.ppm ./output.png
