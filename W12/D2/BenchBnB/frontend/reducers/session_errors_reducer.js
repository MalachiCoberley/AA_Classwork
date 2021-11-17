import { RECEIVE_ERRORS, RECEIVE_CURRENT_USER } from "../actions/session_actions";

const sessionErrorsReducer = (state={}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ERRORS:
      Object.assign({}, state, {[action.errors]: action.errors})
    case RECEIVE_CURRENT_USER:
      return state;
    default:
      return state;
  }
}