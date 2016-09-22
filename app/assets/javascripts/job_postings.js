var postingsFormReady = function() {

  var submitButton = $('#job-posting-submit');
  var currentOccupationOpen = function() { return $('input[name=hiddenSpecificsOnetSocCode]').val(); };
  
  var optionChange = function(event){
    var newValue = $('#combobox').val();
    var postingId = $('input[name=hiddenPostingId]').val();
    var postingSpecificsUrl = $('input[name=hiddenPostingSpecificsUrl]').val();
    var specificsContainer = $('#posting-specifics');

    if (currentOccupationOpen() != newValue) {
      submitButton.prop('disabled', true);
      specificsContainer.empty();

      $.get( postingSpecificsUrl, {onetsoc_code: newValue, posting_id: postingId}).done(
        function( data ) {
          specificsContainer.html(data);
          submitButton.prop('disabled', false);
        }
      );
    } else {
      submitButton.prop('disabled', false);
    }
  };

  $.widget( "custom.combobox", {
    _create: function() {
      this.wrapper = $( "<span>" )
        .addClass( "custom-combobox" )
        .insertAfter( this.element );

      this.element.hide();

      this.element.on('loaded', $.proxy( this, "_updateValue" ));

      this._createAutocomplete();
      this._createShowAllButton();
    },

    _updateValue: function() {
      var selected = this.element.find(':selected').text();
      this.input.val(selected).data("ui-autocomplete")._trigger('change');
    },

    _createAutocomplete: function() {
      var selected = this.element.children( ":selected" ),
        value = selected.val() ? selected.text() : "";

      this.input = $( "<input>" )
        .appendTo( this.wrapper )
        .val( value )
        .attr( "title", "" )
        .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
        .autocomplete({
          delay: 0,
          minLength: 0,
          source: $.proxy( this, "_source" ),
          change: optionChange,
          select: optionChange
        })
        .tooltip({
          classes: {
            "ui-tooltip": "ui-state-highlight"
          }
        });

      this.input.autocomplete( "instance" )._renderItem = function( ul, item ) {
        var element = $( "<li>" ).append( item.label );
        if (item.percent) {
          element.append( "<span class='pull-xs-right font-italic text-sm'>" + item.percent + "</span>" )
        }
        return element.appendTo( ul );
      };

      this._on( this.input, {
        autocompleteselect: function( event, ui ) {
          ui.item.option.selected = true;
          this._trigger( "select", event, {
            item: ui.item.option
          });
        },

        autocompletechange: "_removeIfInvalid"
      });
    },

    _createShowAllButton: function() {
      var input = this.input,
        wasOpen = false;

      $( "<a>" )
        .attr( "tabIndex", -1 )
        .attr( "title", "Show All Items" )
        .tooltip()
        .appendTo( this.wrapper )
        .button({
          icons: {
            primary: "ui-icon-triangle-1-s"
          },
          text: false
        })
        .removeClass( "ui-corner-all" )
        .addClass( "custom-combobox-toggle ui-corner-right" )
        .on( "mousedown", function() {
          wasOpen = input.autocomplete( "widget" ).is( ":visible" );
        })
        .on( "click", function() {
          input.trigger( "focus" );

          // Close if already visible
          if ( wasOpen ) {
            return;
          }

          // Pass empty string as value to search for, displaying all results
          input.autocomplete( "search", "" );
        });
    },

    _source: function( request, response ) {
      var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
      response( this.element.children( "option" ).map(function() {
        var text = $( this ).text();
        //var alt = $( this ).val('alt');
        if ( this.value && ( !request.term || matcher.test(text) ) )
          return {
            label: text,
            value: text,
            option: this,
            percent: $( this ).attr('percent')
          };
      }) );
    },

    _removeIfInvalid: function( event, ui ) {

      // Selected an item, nothing to do
      if ( ui.item ) {
        return;
      }

      // Search for a match (case-insensitive)
      var value = this.input.val(),
        valueLowerCase = value.toLowerCase(),
        valid = false;
      this.element.children( "option" ).each(function() {
        if ( $( this ).text().toLowerCase() === valueLowerCase ) {
          this.selected = valid = true;
          return false;
        }
      });

      // Found a match, nothing to do
      if ( valid ) {
        return;
      }

      // Remove invalid value
      this.input
        .val( "" )
        .attr( "title", value + " didn't match any item" )
        .tooltip( "open" );
      this.element.val( "" );
      this._delay(function() {
        this.input.tooltip( "close" ).attr( "title", "" );
      }, 2500 );
      this.input.autocomplete( "instance" ).term = "";
    },

    _destroy: function() {
      this.wrapper.remove();
      this.element.show();
    }
  });

  $( "#combobox" ).combobox();

  $( "#industry" ).unbind().change(function(event) {
    var newIndustryId = event.target.value;
    var industryOccupationsUrl = $('input[name=hiddenIndustryOccupationsUrl]').val();

    submitButton.prop('disabled', true);

    $.get( industryOccupationsUrl, { industry_id: newIndustryId, current: currentOccupationOpen()}).done(
      function( data ) {
        $( "#combobox" ).html(data).trigger('loaded');
      }
    );

  });

};


$(document).on('turbolinks:load', postingsFormReady);

