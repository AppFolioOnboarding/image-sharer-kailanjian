/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import Sinon from 'sinon';
import App from '../../components/App';
import * as Helper from '../../utils/helper';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<App />);
    assert(wrapper.contains('Tell us what you think'));
    assert(wrapper.exists('form'));
    assert.strictEqual(wrapper.find('.form-group').length, 2);
    assert(wrapper.find('footer').contains('Copyright: Appfolio Inc. Onboarding'));
  });

  it('should show success flash on success', () => {
    const wrapper = mount(<App />);

    wrapper.setState({ status: 'success' });
    assert(wrapper.contains('Successfully submitted feedback!'));

    wrapper.setState({ status: 'loading' });
    assert(wrapper.contains('Submitting feedback please wait...'));

    wrapper.setState({ status: 'error' });
    assert(wrapper.contains('Could not submit feedback! ' +
      'Please check that you filled in both fields.'));
  });

  describe('should post form data to /api/feedbacks', () => {
    const sandbox = Sinon.createSandbox();
    const postStub = sandbox.stub(Helper, 'post');
    const eventMock = { preventDefault() {} };

    it('should notify on success', () => {
      const wrapper = mount(<App />);

      wrapper.setState({ commentInput: 'Comment' });
      wrapper.setState({ nameInput: 'John Doe' });

      const component = wrapper.instance();

      postStub.returns(Promise.resolve());

      return component.handleSubmit(eventMock).then(() => {
        assert(
          postStub.getCall(0).args,
          ['/api/feedbacks', {
            feedback: {
              name: 'John Doe',
              comment: 'Comment'
            }
          }
          ]
        );
        assert(wrapper.instance().state.status, 'success');
      });
    });

    it('should notify on failure', () => {
      const wrapper = mount(<App />);

      wrapper.setState({ commentInput: '' });

      const component = wrapper.instance();
      postStub.returns(Promise.reject());

      return component.handleSubmit(eventMock).catch(() => {
        assert(
          postStub.getCall(0).args,
          ['/api/feedbacks', {
            feedback: {
              name: 'John Doe',
              comment: ''
            }
          }]
        );
        assert(wrapper.instance().state.status, 'error');
      });
    });
  });

  it('should show error flash on failure', () => {
    const wrapper = mount(<App />);

    assert(wrapper.find('div').length, 1);
  });
});
