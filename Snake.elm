module Snake exposing (Snake, draw)

import Collage exposing (collage, Form, group)
import Color exposing (Color)
import Block exposing (Location, BlockSize, draw)


type alias Scale =
    Location


type alias Snake =
    List Scale


draw : BlockSize -> Snake -> Form
draw size snake =
    let
        block scale =
            Block.draw size { location = scale, color = Color.green }
    in
        List.map block snake |> group
