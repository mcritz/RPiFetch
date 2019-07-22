import sys
from inky import InkyPHAT
from PIL import Image, ImageFont, ImageDraw
from font_fredoka_one import FredokaOne

inky_display = InkyPHAT("red")
inky_display.set_border(inky_display.BLACK)

img = Image.new("P", (inky_display.WIDTH, inky_display.HEIGHT))
draw = ImageDraw.Draw(img)

draw.rectangle([(0, 0), img.size], fill=inky_display.RED)

font = ImageFont.truetype(FredokaOne, 22)

message = sys.argv[1]

print("will display: ")
print(message)

w, h = font.getsize(message)

x = (inky_display.WIDTH / 2) - (w / 2)
y = (inky_display.HEIGHT / 2) - (h / 2)

draw.text((x,y), message, inky_display.WHITE, font)
img.save("image.png")
inky_display.set_image(img)
inky_display.show()