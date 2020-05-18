import Component from '@ember/component';
import moment from 'moment';
import {computed} from '@ember/object';
import {mapBy} from '@ember/object/computed';
import {inject as service} from '@ember/service';

export default Component.extend({

    classNames: ['form-group', 'for-select'],

    defaultLocale: null,
    //availableLocales:[{name:'en',label:'English'},{name:'es',label:'Spanish'},{name:'ca@valencia',label:"Valencian"}],

    // Allowed actions
    update: () => {},

    availableLocaleNames: mapBy('availableLocales', 'name'),

    hasLocaleOverride: computed('defaultLocale', 'availableLocaleNames', function () {
        let defaultLocale = this.defaultLocale;
        let availableLocaleNames = this.availableLocaleNames;

        return !availableLocaleNames.includes(defaultLocale);
    }),

    selectedLocale: computed('defaultLocale', 'availableLocales', 'hasLocaleOverride', function () {
        let hasLocaleOverride = this.hasLocaleOverride;
        let defaultLocale = this.defaultLocale;
        let availableLocales = this.availableLocales;

        if (hasLocaleOverride) {
            return {name: '', label: ''};
        }

        return availableLocales
            .filterBy('name', defaultLocale)
            .get('firstObject');
    }),

    selectableLocales: computed('availableLocales', 'hasLocaleOverride', function () {
        let hasLocaleOverride = this.hasLocaleOverride;
        let availableLocales = this.availableLocales;

        if (hasLocaleOverride) {
            return [{name: '', label: ''}, ...availableLocales];
        }

        return availableLocales;
    }),

    actions: {
        setLocale(locale) {
            this.update(locale);
        }
    }
});
