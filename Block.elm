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


main : Html a
main =
    let
        apple =
            { location = ( 1, 4 ), color = Color.red }

        snake =
            [ { location = ( 1, 0 ), color = Color.green }
            , { location = ( 0, 1 ), color = Color.green }
            , { location = ( 0, 2 ), color = Color.green }
            ]

        blocks =
            apple :: snake
    in
        toHtml (collage 500 500 (List.map (draw 25) blocks))
