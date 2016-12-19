module SnakeGame exposing (main)

import AnimationFrame
import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Snake exposing (draw, Snake)
import Apple exposing (draw, Apple)
import Time exposing (Time)


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\_ -> AnimationFrame.times CurrentTick)
        }


type alias Model =
    { snake : Snake, apple : Apple, lastUpdate : Time }


init : Model
init =
    { snake = [ ( 1, 1 ), ( 1, 2 ) ]
    , apple = ( 0, -1 )
    , lastUpdate = 0
    }


type Msg
    = CurrentTick Time


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        CurrentTick time ->
            if time - model.lastUpdate > 100 then
                step { model | lastUpdate = time } ! []
            else
                model ! []


step : Model -> Model
step model =
    let
        snake =
            List.map (\( x, y ) -> ( x, y + 1 )) model.snake
    in
        { model | snake = snake }


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
