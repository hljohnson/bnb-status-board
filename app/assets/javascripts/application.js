// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require tether
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).on('click', 'input:checkbox', function() {
	var project_id = $(this).attr("project_id")
	var task_id = $(this).attr("task_id");
	$.ajax({
		url: '/projects/'+project_id+'/tasks/'+task_id+'/update_state',
		type: 'put'
	})
});
