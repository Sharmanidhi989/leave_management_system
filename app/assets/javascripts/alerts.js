(function() {
  App.room = App.cable.subscriptions.create("WebNotificationsChannel", {
    received: function(data) {
      if(data['employee_id'] == $('#employee_id').text()){
      return $('#notification div').append('<li>' + data['notification'] + '</li>');
      }
    }
  });

}).call(this);