module Snake exposing (main)

import Collage exposing (collage, Form, group)
import Color exposing (Color)
import Element exposing (show, toHtml)
import Html exposing (Html)
import Block exposing (Block, BlockSize, draw)


type alias Snake =
    List Block


draw : BlockSize -> Snake -> Form
draw size snake =
    List.map (Block.draw size) snake |> group


main : Html a
main =
    let
        blockSize =
            25

        snake =
            [ { position = { x = 0, y = 0 }, color = Color.green }
            , { position = { x = 0, y = 1 }, color = Color.green }
            , { position = { x = 0, y = 2 }, color = Color.green }
            ]
    in
        snake
            |> draw blockSize
            |> flip (::) []
            |> collage 500 500
            |> toHtml
