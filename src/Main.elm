module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Attribute, Html, button, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { count : Int
    , firstName : String
    , lastName : String
    }


init : Model
init =
    Model 0 "firstname" "lastname"


type Msg
    = Increment
    | Decrement
    | Reset
    | FirstName String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            let
                newModel =
                    { model | count = model.count + 1 }
            in
            newModel

        Decrement ->
            let
                newModel =
                    { model | count = model.count - 1 }
            in
            newModel

        Reset ->
            let
                newModel =
                    { model | count = 0 }
            in
            newModel

        FirstName input ->
            let
                newModel =
                    { model | firstName = input }
            in
            newModel


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div [] [ text (String.fromInt model.count) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        , div []
            [ button [ onClick Reset ] [ text "reset" ]
            ]
        , input [ value model.firstName, onInput FirstName ] []
        , div [] [ text model.firstName ]
        ]
