import strformat
import math

#[
  How to customize it to produce a different flag?
  1) set width and height
  2) edit the `hungary()` function and rename it
     this is the shader
  Optional: add your name in a comment, like this:
  Written by: Laszlo Szathmary <jabba.laci@gmail.com>
]#

# flag of Hungary:
# horizontally striped red-white-green national flag
# Its width-to-length ratio is 2 to 3.
const
  unit = 250
  WIDTH = unit * 3
  HEIGHT = unit * 2

type
  RGB = tuple[r, g, b: float]

# https://www.flagcolorcodes.com/hungary
func hungary(u, v: float): RGB =
  if v < 1/3:
    (206 / 255, 41 / 255, 57 / 255)
  elif v > 2/3:
    (71 / 255, 112 / 255, 80 / 255)
  else:
    (1.0, 1.0, 1.0)

proc main() =
  let fname = "output.ppm"
  let f = open(fname, fmWrite)
  defer: f.close()

  f.writeLine("P6")
  f.writeLine(&"{WIDTH} {HEIGHT} 255")

  for y in 0 ..< HEIGHT:      # row
    for x in 0 ..< WIDTH:     # col
      let
        u = x / WIDTH
        v = y / HEIGHT
        (r, g, b) = hungary(u, v)

      f.write(chr(int(r * 255)))
      f.write(chr(int(g * 255)))
      f.write(chr(int(b * 255)))

  echo "done"

# ############################################################################

when isMainModule:
  main()
