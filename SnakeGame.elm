module SnakeGame exposing (main)

import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Snake exposing (draw, Snake)
import Apple exposing (draw, Apple)


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = \x y -> ( y, Cmd.none )
        , subscriptions = \x -> Sub.none
        }


type alias Model =
    { snake : Snake, apple : Apple }


type Msg
    = NoOp


init : Model
init =
    { snake = [ ( 1, 1 ), ( 1, 2 ) ]
    , apple = ( 0, -1 )
    }


update : Model -> Cmd -> ( Model, Cmd a )
update model cmd =
    ( model, Cmd.none )


view : Model -> Html a
view { snake, apple } =
    let
        blockSize =
            25

        blocks =
            [ Apple.draw blockSize apple, Snake.draw blockSize snake ]
    in
        blocks
            |> collage 500 500
            |> toHtml
