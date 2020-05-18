import Route from '@ember/routing/route';
import {inject as service} from '@ember/service';

export default Route.extend({
    intl: service(),

    controllerName: 'error',
    templateName: 'error',

    model() {
        return {
            status: 404
        };
    },

    buildRouteInfoMetadata() {
        return {
            titleToken: this.intl.t('pageTitle.Error'),
            mainClasses: ['gh-main-white']
        };
    }
});
