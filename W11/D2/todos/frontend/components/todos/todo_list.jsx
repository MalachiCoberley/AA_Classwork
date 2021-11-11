import React from "react";
import TodoListItem from './todo_list_item'

export default (props) => {
  return (
    <ul>
      <TodoListItem props={props}/>
    </ul>
  )
}