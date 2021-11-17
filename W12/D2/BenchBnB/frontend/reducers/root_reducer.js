import {combineReducers} from 'redux'
import sessionReducer from './sessions_reducer'
import entitiesReducer from './entities_reducer'
import errorsReducer from './errors_reducer'

const rootReducer = combineReducers({
  sessions: sessionReducer,
  entities: entitiesReducer,
  errors: errorsReducer
})

export default rootReducer;