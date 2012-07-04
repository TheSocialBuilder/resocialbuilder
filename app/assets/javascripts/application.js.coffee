#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require ckeditor/init

jQuery ->
  $("form[data-remote]").bind "ajax:before", ->
    for instance of CKEDITOR.instances
      CKEDITOR.instances[instance].updateElement()