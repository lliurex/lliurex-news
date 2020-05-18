import Component from '@ember/component';
import formatMarkdown from 'ghost-admin/utils/format-markdown';
import layout from '../templates/components/koenig-card-markdown';
import {computed} from '@ember/object';
import {utils as ghostHelperUtils} from '@tryghost/helpers';
import {htmlSafe} from '@ember/string';
import {isBlank} from '@ember/utils';
import {run} from '@ember/runloop';
import {inject as service} from '@ember/service';
import {set} from '@ember/object';
import {task, timeout} from 'ember-concurrency';

const {countWords, countImages} = ghostHelperUtils;
const MIN_HEIGHT = 130;

export default Component.extend({
    intl: service(),

    layout,

    // attrs
    payload: null,
    isSelected: false,
    isEditing: false,
    headerOffset: 0,

    // internal attrs
    bottomOffset: 0,
    preventClick: false,

    // closure actions
    editCard() {},
    saveCard() {},
    selectCard() {},
    deselectCard() {},
    deleteCard() {},
    registerComponent() {},

    counts: computed('renderedMarkdown', function () {
        return {
            wordCount: countWords(this.renderedMarkdown),
            imageCount: countImages(this.renderedMarkdown)
        };
    }),

    renderedMarkdown: computed('payload.markdown', function () {
        return htmlSafe(formatMarkdown(this.payload.markdown));
    }),

    toolbar: computed('isEditing', function () {
        if (this.isEditing) {
            return false;
        }

        return {
            items: [{
                buttonClass: 'fw4 flex items-center white',
                icon: 'koenig/kg-edit',
                iconClass: 'fill-white',
                title: this.intl.t('koenig.md.Edit'),
                text: '',
                action: run.bind(this, this.editCard)
            }]
        };
    }),

    init() {
        this._super(...arguments);

        if (!this.payload) {
            this.set('payload', {});
        }

        // subtract toolbar height from MIN_HEIGHT so the trigger happens at
        // the expected position without forcing the min height to be too small
        this.set('bottomOffset', -MIN_HEIGHT - 49);

        this.registerComponent(this);
    },

    willDestroyElement() {
        this._super(...arguments);
        this._teardownResizeHandler();
    },

    actions: {
        enterEditMode() {
            this._preventAccidentalClick.perform();
        },

        leaveEditMode() {
            if (isBlank(this.payload.markdown)) {
                // afterRender is required to avoid double modification of `isSelected`
                // TODO: see if there's a way to avoid afterRender
                run.scheduleOnce('afterRender', this, this.deleteCard);
            }
        },

        updateMarkdown(markdown) {
            let payload = this.payload;
            let save = this.saveCard;
           // LLIUREX. Replace emojis to avoid error
            markdown=markdown.replace(/(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g, '');

            set(payload, 'markdown', markdown);

            // update the mobiledoc and stay in edit mode
            save(payload, false);
        },

        // fires if top comes into view 0 px from viewport top
        // fires if top comes into view MIN_HEIGHTpx above viewport bottom
        topEntered() {
            this._isTopVisible = true;
            run.scheduleOnce('actions', this, this._applyToolbarStyles);
        },

        // fires if top leaves viewport 0 px from viewport top
        // fires if top leaves viewport MIN_HEIGHTpx above viewport bottom
        topExited() {
            let top = this._topElement.getBoundingClientRect().top;
            this._isTopVisible = false;
            this._isTopAbove = top < 0;
            run.scheduleOnce('actions', this, this._applyToolbarStyles);
        },

        bottomEntered() {
            this._isBottomVisible = true;
            run.scheduleOnce('actions', this, this._applyToolbarStyles);
        },

        bottomExited() {
            let top = this._bottomElement.getBoundingClientRect().top;
            this._isBottomVisible = false;
            this._isBottomBelow = top > window.innerHeight;
            run.scheduleOnce('actions', this, this._applyToolbarStyles);
        },

        registerTop(element) {
            this._topElement = element;
        },

        registerBottom(element) {
            this._bottomElement = element;
        }
    },

    _applyToolbarStyles() {
        let toolbar = this.element.querySelector('.editor-toolbar');

        if (!toolbar) {
            return;
        }

        let {left, width} = this._containerDimensions();

        let style = '';
        let stuckTop = `top: ${MIN_HEIGHT}px; bottom: auto`;
        let fixedBottom = `position: fixed; left: ${left + 1}px; width: ${width - 2}px`;
        let stuckBottom = '';

        if (this._isTopVisible && this._isBottomVisible) {
            style = stuckBottom;
        }

        if (this._isTopVisible && !this._isBottomVisible) {
            style = fixedBottom;
        }

        if (!this._isTopVisible && !this._isTopAbove) {
            style = stuckTop;
        }

        if (!this._isTopVisible && this._isBottomVisible) {
            style = stuckBottom;
        }

        if (!this._isTopVisible && !this._isBottomVisible && this._isTopAbove && this._isBottomBelow) {
            style = fixedBottom;
        }

        // set up resize watchers if in fixed position because we have to
        // recalculate left position and width
        if (!this._resizeHandler && style === fixedBottom) {
            this._setupResizeHandler();
        } else if (this._resizeHandler && style !== fixedBottom) {
            this._teardownResizeHandler();
        }

        // account for the mobile nav bar when in fixed position
        if (style === fixedBottom) {
            let mobileNav = document.querySelector('.gh-mobile-nav-bar');

            if (mobileNav.offsetHeight) {
                style = `${style}; bottom: ${mobileNav.offsetHeight}px`;
            }
        }

        toolbar.setAttribute('style', style);
    },

    _containerDimensions() {
        return this.element.querySelector('.kg-card-selected').getBoundingClientRect();
    },

    _setupResizeHandler() {
        if (this._resizeHandler) {
            return;
        }

        this._resizeHandler = run.bind(this, this._applyToolbarStyles);
        window.addEventListener('resize', this._resizeHandler);
    },

    _teardownResizeHandler() {
        window.removeEventListener('resize', this._resizeHandler);
        this._resizeHandler = null;
    },

    // when entering edit mode it can be easy to accidentally click where the
    // toolbar is inserted. Setting `preventClick` to true adds an overlay, so
    // we set that for half a second to stop double-clicks hitting the toolbar
    _preventAccidentalClick: task(function* () {
        this.set('preventClick', true);
        yield timeout(500);
        this.set('preventClick', false);
    })

});
