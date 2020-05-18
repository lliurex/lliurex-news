import BaseValidator from './base';
import validator from 'validator';
import {isBlank} from '@ember/utils';

 /* LLIUREX  Changes to user invitation form to add user */

export default BaseValidator.create({
    properties: ['user', 'role','password'],

    user(model) {
        let user = model.get('user');
        if (isBlank(user)) {
            model.get('errors').add('user', this.t('validation.Please enter an username.'));
            this.invalidate();
        } 
    },

    role(model) {
        let role = model.get('role');

        if (isBlank(role)) {
            model.get('errors').add('role', this.t('validation.Please select a role.'));
            model.get('hasValidated').pushObject('role');
            this.invalidate();
        }
    },
     
   password(model){
	   
	const BAD_PASSWORDS = [
	    '1234567890',
	    'qwertyuiop',
	    'qwertzuiop',
	    'asdfghjkl;',
	    'abcdefghij',
	    '0987654321',
	    '1q2w3e4r5t',
	    '12345asdfg',
	    '123456',
	    'qwerty',
	    'qwertz',
	    'asdfgh',
	    'abcdef',
	    '0987654',
	    '1q2w3e',
	    '12asd'
    
	];
	
	const DISALLOWED_PASSWORDS = ['ghost', 'password', 'passw0rd','news'];   
	   
	let email=model.get('user')+"@llxnews.com";  
	let newPassword = model.get('password');
        let ne2Password = model.get('password2');

        // validation only marks the requested property as validated so we
        // have to add properties manually
        model.get('hasValidated').addObject('password');
        model.get('hasValidated').addObject('password2');

        if (isBlank(newPassword) && isBlank(ne2Password)) {
            model.get('errors').add('password', this.t('validation.Sorry, passwords can\'t be blank'));
            this.invalidate();
        } else {
            if (!validator.equals(newPassword, ne2Password || '')) {
                model.get('errors').add('password2', this.t('validation.Your new passwords do not match'));
                this.invalidate();
            }

	}
	// password must be longer than 6 characters
        
	if (!validator.isLength(newPassword || '', 6)) {
            model.get('errors').add('password', this.t('validation.Password must be at least 6 characters long'));
            this.invalidate();
        }
	   


        // dissallow password from badPasswords list (e. g. '1234567890')
	    
	if (BAD_PASSWORDS.indexOf(newPassword) > -1) {
		model.get('errors').add('password',this.t('validation.Sorry, you cannot use an insecure password'));
                this.invalidate();
	}

	if (DISALLOWED_PASSWORDS.indexOf(newPassword.toLowerCase()) > -1) {
		model.get('errors').add('password',this.t('validation.Sorry, you cannot use an insecure password'));
                this.invalidate();
	}	
	
      
    },

     
});
//export default inviteValidator.create();

