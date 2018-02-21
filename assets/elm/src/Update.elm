module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        subscribeForm =
            model.subscribeForm

        formFields =
            extractFormFields model.subscribeForm
    in
        case msg of
            HandleFullNameInput value ->
                { model | subscribeForm = Editing { formFields | fullName = value } } ! []

            HandleEmailInput value ->
                { model | subscribeForm = Editing { formFields | email = value } } ! []

            HandleFormSubmit ->
                { model | subscribeForm = Saving formFields } ! []

            SubscribeResponse (Ok result) ->
                { model | subscribeForm = Success } ! []

            SubscribeResponse (Err (BadStatus response)) ->
                case Decode.decodeString validationErrorsDecoder response.body of
                    Ok validationErrors ->
                        { model | subscribeForm = Invalid { formFields | recaptchaToken = Nothing } validationErrors } ! [ Ports.resetRecaptcha () ]

                    Err error ->
                        { model | subscribeForm = Errored { formFields | recaptchaToken = Nothing } "Oops! Something went wrong!" } ! [ Ports.resetRecaptcha () ]

            SubscribeResponse (Err error) ->
                { model | subscribeForm = Errored { formFields | recaptchaToken = Nothing } "Oops! Something went wrong!" } ! [ Ports.resetRecaptcha () ]

            SetRecaptchaToken token ->
                { model | subscribeForm = Editing { formFields | recaptchaToken = Just token } } ! []
