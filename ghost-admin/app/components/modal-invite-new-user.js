/* 
LLIUREX 21/04/2020. Added changes to use invite process to add new users
*/
import ModalComponent from 'ghost-admin/components/modal-base';
import RSVP from 'rsvp';
import ValidationEngine from 'ghost-admin/mixins/validation-engine';
import {A as emberA} from '@ember/array';
import {inject as service} from '@ember/service';
import {task} from 'ember-concurrency';
import Controller, {inject as controller} from '@ember/controller';
import {alias} from '@ember/object/computed';
import {isArray as isEmberArray} from '@ember/array';
import {
    isVersionMismatchError
} from 'ghost-admin/services/ajax';
import {get} from '@ember/object';


const {Promise} = RSVP;

export default ModalComponent.extend(ValidationEngine, {
    notifications: service(),
    store: service(),
    intl: service(),
    session: service(),
    ajax: service(),
    ghostPaths: service(),
    config: service(),
    settings: service(),	

    classNames: 'modal-content invite-new-user',

    role: null,
    roles: null,
    authorRole: null,

    validationType: 'inviteUser',

    init() {
        this._super(...arguments);
    },

    didInsertElement() {
        this._super(...arguments);
        this.fetchRoles.perform();
    },

    willDestroyElement() {
        this._super(...arguments);
        // TODO: this should not be needed, ValidationEngine acts as a
        // singleton and so it's errors and hasValidated state stick around
        this.errors.clear();
        this.set('hasValidated', emberA());
    },

    actions: {
        setRole(role) {
            this.set('role', role);
            this.errors.remove('role');
        },

        confirm() {
            this.sendInvitation.perform();
        }
    },

    validate() {
        let user=this.user;
        let email = this.user+"@llxnews.com";
	let password=this.password;
	let password2=this.password2;

        // TODO: either the validator should check the email's existence or
        // the API should return an appropriate error when attempting to save
        return new Promise((resolve, reject) => this._super().then(() => RSVP.hash({
            users: this.store.findAll('user', {reload: true}),
            //invites: this.store.findAll('invite', {reload: true})
        }).then((data) => {
            let existingUser = data.users.findBy('email', email);
            //let existingInvite = data.invites.findBy('email', email);

          //  if (existingUser || existingInvite) {
	    if (existingUser) {
                this.errors.clear('user');
               // if (existingUser) {
                    this.errors.add('user', this.intl.t('validation.A user already exists'));
               /* } else {
                    this.errors.add('email', this.intl.t('validation.A user with that email address was already invited.'));
                }*/

                // TODO: this shouldn't be needed, ValidationEngine doesn't mark
                // properties as validated when validating an entire object
                this.hasValidated.addObject('user');
                reject();
            } else {
                resolve();
            }
        }), () => {
            // TODO: this shouldn't be needed, ValidationEngine doesn't mark
            // properties as validated when validating an entire object
            this.hasValidated.addObject('user');
            reject();
        }));
    },

    fetchRoles: task(function * () {
        let roles = yield this.store.query('role', {permissions: 'assign'});
        let authorRole = roles.findBy('name', 'Author');

        this.set('roles', roles);
        this.set('authorRole', authorRole);

        if (!this.role) {
            this.set('role', authorRole);
        }
    }),

    sendInvitation: task(function* () {
        let email = this.user+"@llxnews.com";
        let role = this.role;
	let name=this.user;
	let password=this.password;
	let passoword2=this.password2;
        let notifications = this.notifications;
	let invite;

        try {
            yield this.validate();
	
	    try{		
			invite = this.store.createRecord('invite', {
			email,
			role
			});

			yield invite.save();
			yield this._completeInvitation();
			notifications.showNotification(this.int.t('User created'), {icon: 'user-group2', key: 'invite.send.success', description:this.intl.t( 'User created successfully')});
			yield this.store.query('user', {limit: 'all'});

			this.send('closeModal');

			    /*			
			    // If sending the invitation email fails, the API will still return a status of 201
			    // but the invite's status in the response object will be 'invited-pending'.
			    if (invite.get('status') === 'pending') {
				notifications.showAlert(this.intl.t('Invitation email was not sent.'), {type: 'error', key: 'invite.send.failed', description: this.intl.t('Please try resending.')});
			    } else {
				notifications.showNotification(this.intl.t('Invitation sent'), {icon: 'send-email', key: 'invite.send.success', description: `${email}`});
			    }

			    this.send('closeModal');
			    */	
		}catch(e){
			yield this._completeInvitation();
			yield this.store.query('user', {limit: 'all'});

			notifications.showNotification(this.intl.t('User created'), {icon: 'user-group2', key: 'invite.send.success', description:this.intl.t('User created successfully')});
			
			this.send('closeModal');
			
		}	
        } catch (error) {
            // validation will reject and cause this to be called with no error
            if (error) {
               // invite.deleteRecord();
                notifications.showAPIError(error, {key: 'invite.send'});
                this.send('closeModal');
            }
        }
    }).drop(),

      _completeInvitation() {
		let authUrl = this.get('ghostPaths.url').api('authentication', 'invitation');
		let name=this.user;
	        let email=this.user+"@llxnews.com";
		let password=this.password;
	        let role = this.role;

	      
		return this.ajax.post(authUrl, {
		    dataType: 'json',
		    data: {
			invitation: [{
			    name: name,
			    email: email,
			    password: password,
			    role_id:role
			}]
		    }
		});
    },

});
