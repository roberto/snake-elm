module Apple exposing (Apple, draw)

import Collage exposing (Form)
import Color exposing (Color)
import Block exposing (Location, BlockSize, draw)


type alias Apple =
    Location


draw : BlockSize -> Apple -> Form
draw size location =
    Block.draw size { location = location, color = Color.red }
