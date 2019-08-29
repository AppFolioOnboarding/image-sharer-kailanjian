import React from 'react';
import { Container, Form, FormGroup, Label, Input, Button } from 'reactstrap';
import Header from './Header';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      nameInput: '',
      commentsInput: '',
      status: 'none'
    };
    this.handleNameInputChange.bind(this);
  }

  handleSubmit = (event) => {
  };

   handleNameInputChange = (event) => {
     this.setState({ nameInput: event.target.value });
   };

  handleCommentsInputChange = (event) => {
    this.setState({ commentsInput: event.target.value });
  };

  render() {
    return (
      <div>
        <Container>
          <Header title="Tell us what you think" />
          <Form action="/api/feedbacks" onSubmit={this.handleSubmit} method="POST">
            <FormGroup>
              <Label for="nameInput">Your Name:</Label>
              <Input
                name="name"
                id="nameInput"
                onChange={this.handleNameInputChange}
                value={this.state.nameInput}
              />
            </FormGroup>
            <FormGroup>
              <Label for="commentsTextArea">Comments:</Label>
              <Input
                name="comments"
                type="textarea"
                id="commentsTextArea"
                onChange={this.handleCommentsInputChange}
                value={this.state.commentsInput}
              />
            </FormGroup>
            <Button id="formSubmitButton" color="primary">Submit</Button>
          </Form>
          <footer className="font-small text-center">
            <small>Copyright: Appfolio Inc. Onboarding</small>
          </footer>
        </Container>
      </div>
    );
  }
}

/* TODO: Add Prop Types check*/
