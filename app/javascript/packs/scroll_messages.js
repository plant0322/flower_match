document.addEventListener('turbolinks:load', function() {
  setTimeout(function() {
    var messagesContainer = document.getElementById('messages-container');
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  },300);
});