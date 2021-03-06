import * as APIUtils from '../util/session_api_util'

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
export const LOGOUT_CURRENT_USER = "LOGOUT_CURRENT_USER";
export const RECEIVE_ERRORS = "RECEIVE_ERRORS";

const receiveCurrentUser = user => {
    return {
        type: RECEIVE_CURRENT_USER,
        user
    }
}

const logoutCurrentUser = () => {
    return{
        type: LOGOUT_CURRENT_USER
    }
}

const receiveErrors = errors => {
    return {
        type: RECEIVE_ERRORS,
        errors
    }
}

export const signup = user => dispatch => (
    APIUtils.signup(user)
    .then(user => dispatch(receiveCurrentUser(user)))
)

export const login = user => dispatch => (
    APIUtils.login(user)
    .then(user => dispatch(receiveCurrentUser(user)))
)

export const logout = () => dispatch => (
    APIUtils.logout()
    .then(() => dispatch(logoutCurrentUser()))
)
