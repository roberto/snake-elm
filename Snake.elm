module Block exposing (main)

import Collage exposing (Form, collage, filled, group, move, outlined, solid, square)
import Color exposing (Color)
import Element exposing (show, toHtml)
import Html exposing (Html)


type Block a
    = Apple Position
    | Scale Position


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
plot position =
    move ( position.x * blockSize, position.y * blockSize )


draw : Block a -> Form
draw block =
    case block of
        Apple position ->
            paint Color.red |> plot position

        Scale position ->
            paint Color.green |> plot position


main : Html a
main =
    let
        items =
            [ Apple { x = 1, y = 4 }
            , Scale { x = 0, y = 0 }
            , Scale { x = 0, y = 1 }
            , Scale { x = 0, y = 2 }
            ]
    in
        toHtml (collage 500 500 (List.map draw items))
