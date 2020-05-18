import PostsRoute from './posts';
import {inject as service} from '@ember/service';

export default PostsRoute.extend({
    intl: service(),

    modelName: 'page',

    buildRouteInfoMetadata() {
        return {
            titleToken: this.intl.t('pageTitle.Pages')
        };
    }
});
