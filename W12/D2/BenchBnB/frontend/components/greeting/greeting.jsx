import React from 'react'

class Greeting extends React.Component{
  constructor(props){
    super(props);
    this.state = this.props.user
  }

  render() {
    return (
      <div className="greeting-form">
        <form>
          
        </form>
      </div>
    )
  }
}

export default Greeting