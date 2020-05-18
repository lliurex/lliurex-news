import AuthenticatedRoute from 'ghost-admin/routes/authenticated';
import {inject as service} from '@ember/service';

export default AuthenticatedRoute.extend({
    notifications: service(),
    intl: service(),

    afterModel(/*model, transition*/) {
        this.notifications.clearAll();
        this.session.invalidate();
    },

    buildRouteInfoMetadata() {
        return {
            titleToken: this.intl.t('pageTitle.Sign Out')
        };
    }
});
