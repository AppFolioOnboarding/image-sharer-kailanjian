import React from 'react';
import { Container, Form, FormGroup, Label, Input, Button, Alert } from 'reactstrap';
import Header from './Header';
import { post } from '../utils/helper';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      nameInput: '',
      commentsInput: '',
      status: 'none'
    };
  }

  handleSubmit = (event) => {
    event.preventDefault();

    this.setState({ status: 'loading' });
    const postResult = post('/api/feedbacks', { feedback: {
      name: this.state.nameInput,
      comments: this.state.commentsInput
    } });

    return postResult.then(() => {
      this.setState({ status: 'success' });
      this.setState({ nameInput: '', commentsInput: '' });
    }).catch(() => {
      this.setState({ status: 'error' });
    });
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
        { this.state.status === 'success' &&
          <Alert color="success">Successfully submitted feedback!</Alert> }
        { this.state.status === 'error' &&
          <Alert color="danger">
            Could not submit feedback! Please check that you filled in both fields.
          </Alert> }
        { this.state.status === 'loading' &&
          <Alert color="info">Submitting feedback please wait...</Alert> }
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
