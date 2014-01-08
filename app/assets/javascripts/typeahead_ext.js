// over ride
$.fn.typeahead.Constructor.prototype.render =  function (items) {
    var that = this;

    items = $(items).map(function (i, item) {
        i = $(that.options.item).attr('data-value', item);
        i.find('a').html(that.highlighter(item));
        return i[0];
    });

    // comment out for free tag input
    // items.first().addClass('active') 
    this.$menu.html(items);
    return this;
};

$.fn.typeahead.Constructor.prototype.move =  function (e) {
      if (!this.shown) return;

      // for free tag input
      var active = this.$menu.find('.active');
      if (!active.length) {
          switch(e.keyCode) {
            case 9: // tab
            case 13: // enter
              this.hide();
              return;
          }
      }

      switch(e.keyCode) {
        case 9: // tab
        case 13: // enter
        case 27: // escape
          e.preventDefault();
          break;

        case 38: // up arrow
          e.preventDefault();
          this.prev();
          break;

        case 40: // down arrow
          e.preventDefault();
          this.next();
          break;
      }
      e.stopPropagation();
};