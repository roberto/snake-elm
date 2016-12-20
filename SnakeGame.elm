module SnakeGame exposing (main)

import AnimationFrame
import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Snake exposing (Snake, Model, Msg, view, init, step, update, subscriptions)
import Apple exposing (draw, Apple)
import Time exposing (Time)


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ AnimationFrame.times CurrentTick
                    , Sub.map SnakeMsg Snake.subscriptions
                    ]
        }


type alias Model =
    { snake : Snake.Model, apple : Apple, lastUpdate : Time }


init : Model
init =
    { apple = ( 0, -1 )
    , lastUpdate = 0
    , snake = Snake.init
    }


type Msg
    = CurrentTick Time
    | SnakeMsg Snake.Msg


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        CurrentTick time ->
            if time - model.lastUpdate > 100 then
                { model | lastUpdate = time, snake = Snake.step model.snake } ! []
            else
                model ! []

        SnakeMsg snakeMsg ->
            let
                ( snakeModel, _ ) =
                    Snake.update snakeMsg model.snake
            in
                { model | snake = snakeModel } ! []


view : Model -> Html a
view { snake, apple } =
    let
        blockSize =
            25

        blocks =
            [ Apple.draw blockSize apple, Snake.view blockSize snake ]
    in
        blocks
            |> collage 500 500
            |> toHtml
