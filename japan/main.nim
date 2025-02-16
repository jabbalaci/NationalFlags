import strformat
import math

#[
  Written by: Laszlo Szathmary <jabba.laci@gmail.com>
]#

# https://en.wikipedia.org/wiki/Flag_of_Japan#/media/File:Construction_sheet_of_the_Japanese_flag_EN.svg
const
  unit = 250
  WIDTH = unit * 3
  HEIGHT = unit * 2
  RATIO = WIDTH / HEIGHT
  CIRCLE_RADIUS = (HEIGHT * 3/5) / 2

type
  RGB = tuple[r, g, b: float]

# https://www.flagcolorcodes.com/japan
# border is optional; I added it because of the white color of the flag
func japan(u, v: float, border: bool = false): RGB =
  let
    cx = 0.5
    cy = 0.5
    dx = cx - u
    dy = cy - v
    r = CIRCLE_RADIUS / HEIGHT
  #
  if border:
    return (0.0, 0.0, 0.0)
  # else:
  if (dx * RATIO) ^ 2 + dy ^ 2 <= r ^ 2:  # trick: prevent it to become an ellipse
    (188 / 255, 0.0, 45 / 255)
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
        border: bool = ((y == 0) or (y == HEIGHT-1) or (x == 0) or (x == WIDTH-1))
        (r, g, b) = japan(u, v, border)

      f.write(chr(int(r * 255)))
      f.write(chr(int(g * 255)))
      f.write(chr(int(b * 255)))

  echo "done"

# ############################################################################

when isMainModule:
  main()
