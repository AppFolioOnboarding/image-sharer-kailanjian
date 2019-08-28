/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import App from '../../components/App';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<App />);
    assert(wrapper.contains('Tell us what you think'));
    assert(wrapper.exists('form'));
    assert.strictEqual(wrapper.find('.form-group').length, 2);
    assert(wrapper.find('footer').contains('Copyright: Appfolio Inc. Onboarding'));
  });
});