import Component from '@ember/component';
import moment from 'moment';
import {computed} from '@ember/object';
import {inject as service} from '@ember/service';

export default Component.extend({
    intl: service(),

    tagName: '',

    user: null,

    lastLoginUTC: computed('user.lastLoginUTC', function () {
        let lastLoginUTC = this.get('user.lastLoginUTC');

        return lastLoginUTC ? moment(lastLoginUTC).fromNow() : this.intl.t('(Never)');
    })
});
