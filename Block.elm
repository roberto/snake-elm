module Block exposing (draw, Block, BlockSize, Location)

import Collage exposing (Form, filled, group, move, outlined, solid, square)
import Color exposing (Color)


type alias Block =
    { location : Location
    , color : Color
    }


type alias BlockSize =
    Float


type alias Location =
    ( Float, Float )


paint : BlockSize -> Color -> Form
paint size color =
    let
        shape =
            square size

        content =
            shape |> filled color

        border =
            shape |> outlined (solid Color.black)
    in
        group [ content, border ]


plot : BlockSize -> Location -> (Form -> Form)
plot size ( x, y ) =
    move ( x * size, y * size )


draw : BlockSize -> Block -> Form
draw size { location, color } =
    paint size color |> plot size location
