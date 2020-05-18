/* eslint-disable camelcase */
import Component from '@ember/component';
import RSVP from 'rsvp';
import {computed} from '@ember/object';
import {isBlank, isEmpty} from '@ember/utils';
import {inject as service} from '@ember/service';
import {task, timeout, waitForProperty} from 'ember-concurrency';

export function computedGroup(category) {
    return computed('content', 'currentSearch', function () {
        if (!this.currentSearch || !this.content) {
            return [];
        }

        let intlCategory = this.intl.t(category).toString();
        return this.content.filter((item) => {
            let search = this.currentSearch.toString().toLowerCase();

            return (item.category === intlCategory) && (item.title.toString().toLowerCase().indexOf(search) >= 0);
        });
    });
}

export default Component.extend({
    ajax: service(),
    notifications: service(),
    intl: service(),
    router: service(),
    store: service(),

    content: null,
    contentExpiresAt: false,
    contentExpiry: 30000,
    currentSearch: '',
    selection: null,

    onSelected() {},

    posts: computedGroup('searchInput.Posts'),
    pages: computedGroup('searchInput.Pages'),
    users: computedGroup('searchInput.Users'),
    tags: computedGroup('searchInput.Tags'),

    groupedContent: computed('posts', 'pages', 'users', 'tags', function () {
        let groups = [];

        if (!isEmpty(this.get('posts'))) {
            groups.pushObject({groupName: this.intl.t('searchInput.Posts').toString(), options: this.posts});
        }

        if (!isEmpty(this.get('pages'))) {
            groups.pushObject({groupName: this.intl.t('searchInput.Pages').toString(), options: this.pages});
        }

        if (!isEmpty(this.get('users'))) {
            groups.pushObject({groupName: this.intl.t('searchInput.Users').toString(), options: this.users});
        }

        if (!isEmpty(this.get('tags'))) {
            groups.pushObject({groupName: this.intl.t('searchInput.Tags').toString(), options: this.tags});
        }

        return groups;
    }),

    init() {
        this._super(...arguments);
        this.content = [];
    },

    didRender() {
        this._super(...arguments);

        // force the search box to be focused at all times. Fixes disappearing
        // caret when pressing Escape
        let input = this.element.querySelector('input');
        if (input) {
            input.focus();
        }
    },

    actions: {
        openSelected(selected) {
            if (!selected) {
                return;
            }

            this.onSelected(selected);

            if (selected.category === this.intl.t('searchInput.Posts').toString()) {
                let id = selected.id.replace('post.', '');
                this.router.transitionTo('editor.edit', 'post', id);
            }

            if (selected.category === this.intl.t('searchInput.Pages').toString()) {
                let id = selected.id.replace('page.', '');
                this.router.transitionTo('editor.edit', 'page', id);
            }

            if (selected.category === this.intl.t('searchInput.Users').toString()) {
                let id = selected.id.replace('user.', '');
                this.router.transitionTo('staff.user', id);
            }

            if (selected.category === this.intl.t('searchInput.Tags').toString()) {
                let id = selected.id.replace('tag.', '');
                this.router.transitionTo('tag', id);
            }
        },

        search(term) {
            return this.performSearch.perform(term);
        }
    },

    performSearch: task(function* (term) {
        if (isBlank(term)) {
            return [];
        }

        // start loading immediately in the background
        this.refreshContent.perform();

        // debounce searches to 200ms to avoid thrashing CPU
        yield timeout(200);

        // wait for any on-going refresh to finish
        if (this.refreshContent.isRunning) {
            yield waitForProperty(this, 'refreshContent.isIdle');
        }

        // set dependent CP term and re-calculate CP
        this.set('currentSearch', term);
        return this.groupedContent;
    }).restartable(),

    refreshContent: task(function* () {
        let promises = [];
        let now = new Date();
        let contentExpiresAt = this.contentExpiresAt;

        if (contentExpiresAt > now) {
            return true;
        }

        this.set('content', []);
        promises.pushObject(this._loadPosts());
        promises.pushObject(this._loadPages());
        promises.pushObject(this._loadUsers());
        promises.pushObject(this._loadTags());

        try {
            yield RSVP.all(promises);
        } catch (error) {
            // eslint-disable-next-line
            console.error(error);
        }

        let contentExpiry = this.contentExpiry;
        this.set('contentExpiresAt', new Date(now.getTime() + contentExpiry));
    }).drop(),

    _loadPosts() {
        let store = this.store;
        let postsUrl = `${store.adapterFor('post').urlForQuery({}, 'post')}/`;
        let postsQuery = {fields: 'id,title,page', limit: 'all'};
        let content = this.content;

        return this.ajax.request(postsUrl, {data: postsQuery}).then((posts) => {
            content.pushObjects(posts.posts.map(post => ({
                id: `post.${post.id}`,
                title: post.title,
                category: this.intl.t('searchInput.Posts').toString()
            })));
        }).catch((error) => {
            this.notifications.showAPIError(error, {key: 'search.loadPosts.error'});
        });
    },

    _loadPages() {
        let store = this.store;
        let pagesUrl = `${store.adapterFor('page').urlForQuery({}, 'page')}/`;
        let pagesQuery = {fields: 'id,title,page', limit: 'all'};
        let content = this.content;

        return this.ajax.request(pagesUrl, {data: pagesQuery}).then((pages) => {
            content.pushObjects(pages.pages.map(page => ({
                id: `page.${page.id}`,
                title: page.title,
                category: this.intl.t('searchInput.Pages')
            })));
        }).catch((error) => {
            this.notifications.showAPIError(error, {key: 'search.loadPosts.error'});
        });
    },

    _loadUsers() {
        let store = this.store;
        let usersUrl = `${store.adapterFor('user').urlForQuery({}, 'user')}/`;
        let usersQuery = {fields: 'name,slug', limit: 'all'};
        let content = this.content;

        return this.ajax.request(usersUrl, {data: usersQuery}).then((users) => {
            content.pushObjects(users.users.map(user => ({
                id: `user.${user.slug}`,
                title: user.name,
                category: this.intl.t('searchInput.Users').toString()
            })));
        }).catch((error) => {
            this.notifications.showAPIError(error, {key: 'search.loadUsers.error'});
        });
    },

    _loadTags() {
        let store = this.store;
        let tagsUrl = `${store.adapterFor('tag').urlForQuery({}, 'tag')}/`;
        let tagsQuery = {fields: 'name,slug', limit: 'all'};
        let content = this.content;

        return this.ajax.request(tagsUrl, {data: tagsQuery}).then((tags) => {
            content.pushObjects(tags.tags.map(tag => ({
                id: `tag.${tag.slug}`,
                title: tag.name,
                category: this.intl.t('searchInput.Tags').toString()
            })));
        }).catch((error) => {
            this.notifications.showAPIError(error, {key: 'search.loadTags.error'});
        });
    }
});
