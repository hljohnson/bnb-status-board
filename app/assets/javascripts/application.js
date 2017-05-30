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
