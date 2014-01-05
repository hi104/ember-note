
/*global ace:true */

/**
 copy from Discourse AceEditorView thank you
 https://github.com/discourse/discourse
 **/

/**
 A view that wraps the ACE editor (http://ace.ajax.org/)
 @class AceEditorView
 **/


App.AceEditorView = Ember.View.extend({
    // mode: 'css',
    mode: 'markdown',
    classNames: ['ace-wrapper'],

    contentChanged: (function() {
        if (this.editor && !this.skipContentChangeEvent) {
            return this.editor.getSession().setValue(this.get('content'));
        }
    }).observes('content'),

    render: function(buffer) {
        buffer.push("<div class='ace'>");
        if (this.get('content')) {
            buffer.push(Handlebars.Utils.escapeExpression(this.get('content')));
        }
        return buffer.push("</div>");
    },

    willDestroyElement: function() {
        if (this.editor) {
            this.editor.destroy();
            this.editor = null;
        }
    },

    // TODO jquery selector 
    syncScroll: function () {
        var editor = this.editor;
        var previewContent = $('#preview-content');

        var editorLength = editor.getSession().getLength();
        var editorHeight =  $('.ace').height();
        var previewHeight = previewContent.height();
        var ratio = editor.getFirstVisibleRow() / editorLength;
        $('#preview').scrollTop(ratio * previewHeight);

    },

    didInsertElement: function() {

        var aceEditorView = this;

        var initAce = function() {
            aceEditorView.editor = ace.edit(aceEditorView.$('.ace')[0]);
            aceEditorView.editor.setTheme("ace/theme/chrome");
            aceEditorView.editor.setShowPrintMargin(false);
            // aceEditorView.editor.renderer.setShowGutter(false); 
            aceEditorView.editor.getSession().setUseWrapMode(true);
            aceEditorView.editor.getSession().setMode("ace/mode/" + (aceEditorView.get('mode')));
            aceEditorView.editor.on("change", function(e) {
                aceEditorView.skipContentChangeEvent = true;
                aceEditorView.set('content', aceEditorView.editor.getSession().getValue());
                aceEditorView.skipContentChangeEvent = false;
            });

            aceEditorView.editor.getSession().on('changeScrollTop', function(e){
                aceEditorView.syncScroll();
            });
        };

        if (window.ace) {
            initAce();
        }
    }
});

