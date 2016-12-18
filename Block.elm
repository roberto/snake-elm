module Block exposing (main)

import Collage exposing (Form, collage, filled, group, move, outlined, solid, square)
import Color exposing (Color)
import Element exposing (show, toHtml)
import Html exposing (Html)


type alias Block =
    { position : Position
    , color : Color
    }


type alias Position =
    { x : Float, y : Float }


blockSize : Float
blockSize =
    25


paint : Color -> Form
paint color =
    let
        shape =
            square blockSize

        content =
            shape |> filled color

        border =
            shape |> outlined (solid Color.black)
    in
        group [ content, border ]


plot : Position -> (Form -> Form)
plot { x, y } =
    move ( x * blockSize, y * blockSize )


draw : Block -> Form
draw { position, color } =
    paint color |> plot position


main : Html a
main =
    let
        apple =
            { position = { x = 1, y = 4 }, color = Color.red }

        snake =
            [ { position = { x = 1, y = 0 }, color = Color.green }
            , { position = { x = 0, y = 1 }, color = Color.green }
            , { position = { x = 0, y = 2 }, color = Color.green }
            ]

        blocks =
            apple :: snake
    in
        toHtml (collage 500 500 (List.map draw blocks))
