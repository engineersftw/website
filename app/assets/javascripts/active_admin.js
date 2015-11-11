//= require active_admin/base

$(document).ready(function(){
  var chosen_option = {
    no_results_text: 'No results matched',
    width: '500px'
  }
  $('.chosen-select').chosen(chosen_option);
  $(document).on('has_many_add:after', function(e){
    $('.chosen-select').chosen(chosen_option);
  });
});
