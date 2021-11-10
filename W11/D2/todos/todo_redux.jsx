import React from 'react'
import ReactDOM from 'react-dom'
import configureStore from './frontend/store/store'
import { receiveTodo, receiveTodos, removeTodo } from './frontend/actions/todo_actions'
import { receiveStep, receiveSteps, removeStep } from './frontend/actions/step_actions'

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<h1>Todos App</h1>, document.getElementById("root"))
  
  window.store = configureStore();
  window.receiveTodo = receiveTodo;
  window.receiveTodos = receiveTodos;
  window.removeTodo = removeTodo;
  window.receiveStep = receiveStep;
  window.receiveSteps = receiveSteps;
  window.removeStep = removeStep;
});