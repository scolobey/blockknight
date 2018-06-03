document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/search?q=" + phrase;
    },
    categories: [
      {
        listLocation: "coins"
      }
    ],
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        Turbolinks.visit(url)
        $input.text("")
      }
    }
  }

  $input.easyAutocomplete(options)
});
