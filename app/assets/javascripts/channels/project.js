$(function() {
  $('.project[data-id]').toArray().forEach(function(el) {
    var projectId = $(el).data('id')
    App['project' + projectId] = App.cable.subscriptions.create({ channel: "ProjectChannel", id: projectId }, {
      connected: function() {
        // Called when the subscription is ready for use on the server
      },

      disconnected: function() {
        // Called when the subscription has been terminated by the server
      },

      received: function(data) {
        $('.project[data-id="' + projectId + '"]').replaceWith(data)
      }
    });
  })
})
