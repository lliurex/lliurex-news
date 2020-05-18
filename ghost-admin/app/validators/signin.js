import BaseValidator from './base';
import validator from 'validator';
import {isBlank} from '@ember/utils';

export default BaseValidator.create({
    properties: ['identification', 'signin', 'forgotPassword'],

    identification(model) {
        let id = model.get('identification');
	/* LLIUREX Complete userid with @llxnews.com to obtain internal email*/    
	id+="@llxnews.com";
        if (!isBlank(id) && !validator.isEmail(id)) {
            model.get('errors').add('identification', this.invalidMessage || this.t('validation.Username is not valid'));
	/* LLIUREX*/    
            this.invalidate();
        }
    },

    signin(model) {
        let id = model.get('identification');
	/* LLIUREX Complete userid with @llxnews.com to obtain internal email*/    
	id+="@llxnews.com";
	/* LLIUREX */    
        let password = model.get('password');

        model.get('errors').clear();

        if (isBlank(id)) {
	/* LLIUREX Changes message to require username*/
            model.get('errors').add('identification', this.t('validation.Please enter an username.'));
	/* LLIUREX */    
		this.invalidate();
        }
	/* LLIUREX Disable check 
        if (!isBlank(id) && !validator.isEmail(id)) {
            model.get('errors').add('identification', this.invalidMessage || this.t('validation.Email address is not valid'));
            this.invalidate();
        }
	*/
        if (isBlank(password)) {
            model.get('errors').add('password', this.t('validation.Please enter a password.'));
            this.invalidate();
        }
    },

    forgotPassword(model) {
   	/* LLIUREX Complete userid with @llxnews.com to obtain internal email*/    
        let id = model.get('identification');
	id+="@llxnews.com";
        model.get('errors').clear();
	/* LLIUREX */    

       // if (isBlank(id) || !validator.isEmail(id)) {
	   if (isBlank(id)){	
	    model.get('errors').add('identification', this.invalidMessage || this.t('validation.Username is not valid'));
            this.invalidate();
        }
    }
});
