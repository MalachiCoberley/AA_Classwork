import React from "react";
import TodoListItem from './todo_list_item'
import TodoForm from "./todo_form";

export default (props) => {
  return (
    <div>
      <ul>
        <TodoListItem/>
      </ul>
      <TodoForm/>
    </div>
  )
}