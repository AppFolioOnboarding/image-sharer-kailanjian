import React from 'react';
import { Container, Form, FormGroup, Label, Input, Button } from 'reactstrap';
import Header from './Header';

export default function App() {
  return (
    <div>
      <Container>
        <Header title="Tell us what you think" />
        <Form>
          <FormGroup>
            <Label for="nameInput">Your Name:</Label>
            <Input name="name" id="nameInput" />
          </FormGroup>
          <FormGroup>
            <Label for="commentTextArea">Comments:</Label>
            <Input type="textarea" id="commentTextArea" />
          </FormGroup>
          <Button color="primary">Submit</Button>
        </Form>
        <footer className="font-small text-center">
          <small>Copyright: Appfolio Inc. Onboarding</small>
        </footer>
      </Container>
    </div>
  );
}

/* TODO: Add Prop Types check*/
