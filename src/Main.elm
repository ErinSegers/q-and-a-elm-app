module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h3, h5, input, label, li, p, text, ul)
import Html.Attributes exposing (checked, class, for, id, name, type_, value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { quizName : String
    , intro : String
    , quizScore : Int
    , questions : List QuizItem
    }


type alias QuizItem =
    { question : String
    , options : List QuizOption
    }


type alias QuizOption =
    { text : String
    , rating : Int
    }


init : Model
init =
    Model "Grade Your Team" "Do you know if your team is performing at their highest potential? Take this quiz to find out where your team can improve to max potential." 0 quiz


quiz : List QuizItem
quiz =
    [ { question = "1. My team can clearly articulate their goals"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "2. My team feels recognized for their accomplishments"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "3. All team members have personal development plans and see regular progress towards their goals"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "4. My team feels empowered to make decisions"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "5. My team is more efficient when I’m not there"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "6. My team has productive meetings that everyone is involved in (but only when necessary)"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "7. Team members will openly express their opinions and concerns"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "8. Other people want to be on our team"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "9. My team has created their own set of operating guidelines and practices which they are fully bought into"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    , { question = "10. All team members hold each other, including me, acquizScoreable for outcomes"
      , options =
            [ { text = "Strongly Disagree", rating = 1 }
            , { text = "Disagree", rating = 2 }
            , { text = "Neutral", rating = 3 }
            , { text = "Agree", rating = 4 }
            , { text = "Strongly Agree", rating = 5 }
            ]
      }
    ]


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            let
                newModel =
                    { model | quizScore = model.quizScore + 1 }
            in
            newModel

        Decrement ->
            let
                newModel =
                    { model | quizScore = model.quizScore - 1 }
            in
            newModel

        Reset ->
            let
                newModel =
                    { model | quizScore = 0 }
            in
            newModel


view : Model -> Html Msg
view model =
    div [ class "container-fluid p-0" ]
        [ div [ class "sectionDarkBlue row py-5" ]
            [ div [ class "col-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2 text-center" ]
                [ h1 [ class "text-center mb-3" ] [ text model.quizName ]
                , p [ class "intro" ] [ text model.intro ]
                ]
            ]
        , div [ class "container mb-5" ]
            [ div [ class "questions row" ] (List.map renderQuestion model.questions)
            ]
        , div [ class "sectionDarkBlue container-fluid p-0" ]
            [ div [ class "container py-5" ]
                [ div [ class "row" ]
                    [ div [ class "col-12" ]
                        [ h3 []
                            [ text ("Your Score: " ++ String.fromInt model.quizScore)
                            ]
                        , button [ onClick Reset ] [ text "Retake Quiz" ]
                        ]
                    ]
                ]
            ]
        ]



-- View Helpers


renderQuestion : QuizItem -> Html Msg
renderQuestion quizItem =
    div [ class "col-12" ]
        [ h5 [ class "mt-5 mb-3" ] [ text quizItem.question ]
        , div [] [ renderList quizItem.options ]
        ]


renderList : List QuizOption -> Html msg
renderList options =
    options
        |> List.map (\option -> optionsRating option)
        |> div [ class "row d-flex justify-content-center" ]


optionsRating : QuizOption -> Html msg
optionsRating option =
    div
        [ class "answers text-center flex-even col" ]
        [ input [ type_ "button", name "options p-2", value option.text, class "p-3" ] []
        ]
