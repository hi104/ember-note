ENV = {FEATURES:{'query-params': true}};

marked.setOptions({
    gfm: true,
    tables: true,
    breaks: false,
    pedantic: false,
    sanitize: true,
    smartLists: true,
    langPrefix: "hljs ",
    highlight: function (code, lang) {
        if (lang){
            return hljs.highlight(lang, code).value;
        }else{
            return hljs.highlightAuto(code).value;
        }
    }
});

emojify.setConfig({

    emojify_tag_type : 'div',           // Only run emojify.js on this element
    only_crawl_id    : null,            // Use to restrict where emojify.js applies
    img_dir          : 'assets/emoji',  // Directory for emoji images
    ignored_tags     : {                // Ignore the following tags
        'SCRIPT'  : 1,
        'TEXTAREA': 1,
        'A'       : 1,
        'PRE'     : 1,
        'CODE'    : 1
    }
});
