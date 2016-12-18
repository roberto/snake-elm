module Block exposing (main, draw, Block, BlockSize, Location)

import Collage exposing (Form, collage, filled, group, move, outlined, solid, square)
import Color exposing (Color)
import Element exposing (show, toHtml)
import Html exposing (Html)


type alias Block =
    { location : Location
    , color : Color
    }


type alias BlockSize =
    Float


type alias Location =
    { x : Float
    , y : Float
    }


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
plot size { x, y } =
    move ( x * size, y * size )


draw : BlockSize -> Block -> Form
draw size { location, color } =
    paint size color |> plot size location


main : Html a
main =
    let
        apple =
            { location = { x = 1, y = 4 }, color = Color.red }

        snake =
            [ { location = { x = 1, y = 0 }, color = Color.green }
            , { location = { x = 0, y = 1 }, color = Color.green }
            , { location = { x = 0, y = 2 }, color = Color.green }
            ]

        blocks =
            apple :: snake
    in
        toHtml (collage 500 500 (List.map (draw 25) blocks))
