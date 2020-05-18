import Component from '@ember/component';
import layout from '../templates/components/koenig-plus-menu';
import {CARD_MENU} from '../options/cards';
import {computed} from '@ember/object';
import {htmlSafe} from '@ember/string';
import {run} from '@ember/runloop';
import {inject as service} from '@ember/service';

export default Component.extend({
    intl: service(),
    layout,

    // public attrs
    classNames: ['absolute'],
    attributeBindings: ['style', 'data-kg'],
    editor: null,
    editorRange: null,

    // internal properties
    itemSections: null,
    showButton: false,
    showMenu: false,
    top: 0,
    'data-kg': 'plus-menu',

    // private properties
    _onResizeHandler: null,
    _onWindowMousedownHandler: null,
    _lastEditorRange: null,
    _hasCursorButton: false,
    _onMousemoveHandler: null,
    _onKeydownHandler: null,

    // closure actions
    replaceWithCardSection() {},

    style: computed('top', function () {
        return htmlSafe(`top: ${this.top}px`);
    }),

    init() {
        this._super(...arguments);
        this.itemSections = CARD_MENU
            .map(section => Object.assign(
                {},
                section,
                {title: this.intl.t(`koenig.cards.${section.title}`)},
                {items: section.items.map(item => Object.assign({}, item, {label: this.intl.t(`koenig.cards.${item.label}`)}))}
            ));

        this._onResizeHandler = run.bind(this, this._handleResize);
        window.addEventListener('resize', this._onResizeHandler);

        this._onMousemoveHandler = run.bind(this, this._mousemoveRaf);
        window.addEventListener('mousemove', this._onMousemoveHandler);
    },

    didReceiveAttrs() {
        this._super(...arguments);

        let editorRange = this.editorRange;

        // show the (+) button when the cursor is on a blank P tag
        if (!this.showMenu && editorRange !== this._lastEditorRange) {
            this._showOrHideButton(editorRange);
            this._hasCursorButton = this.showButton;
        }

        // re-position again on next runloop, prevents incorrect position after
        // adding a card at the bottom of the doc
        if (this.showButton) {
            run.next(this, this._positionMenu);
        }

        // hide the menu if the editor range has changed
        if (!this._ignoreRangeChange && this.showMenu && editorRange && !editorRange.isBlank && !editorRange.isEqual(this._lastEditorRange)) {
            this._hideMenu();
        }

        this._lastEditorRange = editorRange;
        this._ignoreRangeChange = false;
    },

    willDestroyElement() {
//LLIUREX: Catched error when load button failed	
	try{
		this._super(...arguments);
		run.cancel(this._throttleResize);
		window.removeEventListener('mousedown', this._onWindowMousedownHandler);
		window.removeEventListener('resize', this._onResizeHandler);
		window.removeEventListener('mousemove', this._onMousemoveHandler);
		window.removeEventListener('keydown', this._onKeydownHandler);
	}catch(e){}
//LLIUREX: Catched error when load button failed	
	
    },

    actions: {
        openMenu() {
            this._showMenu();
        },

        closeMenu() {
            this._hideMenu();
        },

        itemClicked(item) {
//LLIUREX: Catched error when load button failed	
	    try{
		    let range = this._editorRange;

		    if (item.type === 'card') {
			this.replaceWithCardSection(item.replaceArg, range, item.payload);
		    }

		    this._hideButton();
		    this._hideMenu();
	    }catch(e){
			this._hideButton();
			this._hideMenu();
			    
	    }	
	//LLIUREX: Catched error when load button failed			
        }
    },

    _showOrHideButton(editorRange) {
	//LLIUREX: Catched error when load button failed	
	    
	try{    
		if (!editorRange) {
		    this._hideButton();
		    this._hideMenu();
		    return;
		}

		let {head: {section}} = editorRange;

		// show the button if the range is a blank paragraph
		if (editorRange && editorRange.isCollapsed && section && !section.isListItem && (section.isBlank || section.text === '')) {
		    this._editorRange = editorRange;
		    this._showButton();
		    this._hideMenu();
		} else {
		    this._hideButton();
		    this._hideMenu();
		}
	}catch(e){
			this._hideButton();
			this._hideMenu();
			
	}	
	//LLIUREX: Catched error when load button failed	
	
		
		
    },

    _showButton() {
        this._positionMenu();
        this.set('showButton', true);
    },

    _hideButton() {
        this.set('showButton', false);
    },

    // find the "top" position by grabbing the current sections
    // render node and querying it's bounding rect. Setting "top"
    // positions the button+menu container element [data-kg="plus-menu"]
    _positionMenu() {
        // use the cached range if available because `editorRange` may have been
        // lost due to clicks on the open menu
        let {head: {section}} = this._editorRange || this.editorRange;

        if (section) {
            let containerRect = this.element.parentNode.getBoundingClientRect();
            let selectedElement = section.renderNode.element;
            if (selectedElement) {
                let selectedElementRect = selectedElement.getBoundingClientRect();
                let top = selectedElementRect.top - containerRect.top;

                this.set('top', top);
            }
        }
    },

    _showMenu() {
	 //LLIUREX: Catched error when load button failed	
	try{
		this.set('showMenu', true);

		// move the cursor to the blank paragraph, ensures any selected card
		// gets inserted in the correct place because editorRange will be
		// wherever the cursor currently is if the menu was opened via a
		// mouseover button
		this._moveCaretToCachedEditorRange();

		// focus the search immediately so that you can filter immediately
		run.schedule('afterRender', this, function () {
		    this._focusSearch();
		});

		// watch the window for mousedown events so that we can close the menu
		// when we detect a click outside
		this._onWindowMousedownHandler = run.bind(this, this._handleWindowMousedown);
		window.addEventListener('mousedown', this._onWindowMousedownHandler);

		// watch for keydown events so that we can close the menu on Escape
		this._onKeydownHandler = run.bind(this, this._handleKeydown);
		window.addEventListener('keydown', this._onKeydownHandler);
	}catch(e){
		this.set('showMenu', false);
	}
	//LLIUREX: Catched error when load button failed	
    },

    _hideMenu() {
        if (this.showMenu) {
            // reset our cached editorRange
            this._editorRange = null;

            // stop watching the body for clicks and keydown
            window.removeEventListener('mousedown', this._onWindowMousedownHandler);
            window.removeEventListener('keydown', this._onKeydownHandler);

            // hide the menu
            this.set('showMenu', false);
        }
    },

    _focusSearch() {
        let search = this.element.querySelector('input');
        if (search) {
            search.focus();
        }
    },

    _handleWindowMousedown(event) {
        if (!event.target.closest(`#${this.elementId}`)) {
            this._hideMenu();
        }
    },

    _mousemoveRaf(event) {
        if (!this._mousemoveTicking) {
            requestAnimationFrame(run.bind(this, this._handleMousemove, event));
        }
        this._mousemoveTicking = true;
    },

    // show the (+) button when the mouse is over a blank P tag
    _handleMousemove(event) {
        if (!this.showMenu && this.element) {
            let {pageX, pageY} = event;
            let editor = this.editor;

            // add a horizontal buffer to the pointer position so that the
            // (+) button doesn't disappear when the mouse hovers over it due
            // to it being outside of the editor canvas
            let containerRect = this.element.parentNode.getBoundingClientRect();
            if (pageX < containerRect.left) {
                pageX = pageX + 40;
            }

            // grab a range from the editor position under the pointer. We can
            // rely on the same show/hide behaviour of our cursor implementation
            try {
                let position = editor.positionAtPoint(pageX, pageY);
                if (position) {
                    let pointerRange = position.toRange();
                    this._showOrHideButton(pointerRange);
                }
            } catch (e) {
                // mobiledoc-kit can generate the following harmless error
                // from positionAtPoint(x,y) whilst dragging a selection
                // TypeError: Failed to execute 'compareDocumentPosition' on 'Node': parameter 1 is not of type 'Node'.
                if (e instanceof TypeError === false) {
                    throw e;
                }
            }

            // if the button is hidden due to the pointer not being over a blank
            // P but we have a valid cursor position then fall back to the cursor
            // positioning
            if (!this.showButton && this._hasCursorButton) {
                this._showOrHideButton(this.editorRange);
            }
        }

        this._mousemoveTicking = false;
    },

    _handleKeydown(event) {
        if (event.key === 'Escape') {
            // reset the caret position so we have a caret after closing
            this._moveCaretToCachedEditorRange();
            this._hideMenu();
            return;
        }

        let arrowKeys = ['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'];
        if (arrowKeys.includes(event.key)) {
            this._hideMenu();
        }
    },

    _handleResize() {
        if (this.showButton) {
            this._throttleResize = run.throttle(this, this._positionMenu, 100);
        }
    },

    _moveCaretToCachedEditorRange() {
	//LLIUREX: Catched error when load button failed	
	try{
		this._ignoreRangeChange = true;
		this.set('editorRange', this._editorRange);
		this.editor.selectRange(this._editorRange);
	}catch(e){
		this._editorRange=null;
		this.editor.selectRange(this._editorRange);

	}
	//LLIUREX: Catched error when load button failed	
    }

});