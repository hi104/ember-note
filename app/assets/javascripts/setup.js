ENV = {FEATURES:{'query-params': true}};

marked.setOptions({
    langPrefix: "hljs ", 
    highlight: function (code, lang) {
        if (lang){
            return hljs.highlight(lang, code).value;
        }else{
            return hljs.highlightAuto(code).value;
        }
    }
});