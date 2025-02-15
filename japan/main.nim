import strformat
import math

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
func japan(u, v: float): RGB =
  let
    cx = 0.5
    cy = 0.5
    dx = cx - u
    dy = cy - v
    r = CIRCLE_RADIUS / HEIGHT
  #
  if (u == 0.0 or v == 0.0 or u >= 0.998 or v >= 0.997):  # thin black border
    (0.0, 0.0, 0.0)
  elif (dx * RATIO) ^ 2 + dy ^ 2 <= r ^ 2:
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
        (r, g, b) = japan(u, v)

      f.write(chr(int(r * 255)))
      f.write(chr(int(g * 255)))
      f.write(chr(int(b * 255)))

  echo "done"

# ############################################################################

when isMainModule:
  main()
