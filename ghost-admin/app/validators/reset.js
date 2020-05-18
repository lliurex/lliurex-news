import BaseValidator from './base';
import PasswordValidatorMixin from './mixins/password';
import validator from 'validator';
import {isBlank} from '@ember/utils';

const resetValidator = BaseValidator.extend(PasswordValidatorMixin, {
    init() {
        this.properties = this.properties || ['newPassword'];
        this._super(...arguments);
    },

    newPassword(model) {
        let p1 = model.get('newPassword');
        let p2 = model.get('ne2Password');

        if (isBlank(p1)) {
            model.get('errors').add('newPassword', this.t('validation.Please enter a password.'));
            this.invalidate();
        } else if (!validator.equals(p1, p2 || '')) {
            model.get('errors').add('ne2Password', this.t('validation.The two new passwords don\'t match.'));
            this.invalidate();
        }

        this.passwordValidation(model, p1, 'newPassword');
    }
});

export default resetValidator.create();
