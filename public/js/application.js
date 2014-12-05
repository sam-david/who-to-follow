$(document).ready(function() {
  $('.top-bar-heading').css('color', 'rgb(6, 68, 145)');
  bindEvents();
});


function bindEvents() {
  // Bind functions which add, remove, and complete todos to the appropriate
  // elements
  $('.category-link').on('click', searchQuery);
  $('.todo_list').on('click', '.complete', completeTodo);
  $('.todo_list').on('click', '.delete', deleteTodo);

  $('.custom-link').on('click', toggleCustomForm);
  $( "#accordion" ).accordion();
  $( "#accordion" ).accordion({ collapsible: true });
  $('#custom-hashtags').submit(customSearchQuery);

}

function View() {}

function hideWelcome() {
  $('.welcome-heading').hide();
}

function showSuggestion() {
  console.log('hide sug');
  $('.suggestion-heading').show();
}

function toggleCustomForm() {
  $('.custom-form').toggle();
}

function customSearchQuery(event) {
  event.preventDefault();
  console.log('submit worked');
  var form_data = $(this).serialize();
  $.ajax({
    url: '/tweets/search/custom',
    type: 'get',
    data: form_data
  }).done(function(userData) {
    console.log('Users grabbed');
    $('.user-list').empty();
    $.each(userData, function(index, user) {
      renderUser(user);
    })
    showSuggestion();
      hideWelcome();
  }).fail(function() {
    console.log('Render Users Failed!');
  })
}

function searchQuery(event) {
  event.preventDefault();
  console.log("searching");
  $.ajax({
    url: $(this).attr('href'),
    type: 'get'
  }).done(function(userData) {
    console.log('Users grabbed');
    $('.user-list').empty();
    $.each(userData, function(index, user) {
      renderUser(user);
    })
    showSuggestion();
      hideWelcome();
  }).fail(function() {
    console.log('Render Users Failed!');
  })
}

function renderUser(user) {
  console.log(user.link_color);
  html = "";
  html += "<div class='margin'>";
  html +=  "<div class='row user-box' style='border-color:#" + user.link_color + ";'>";
  html +=    "<div class='large-3 medium-3 columns'>";
  html +=       "<img src=" + user.image_url + " class='profile-image'>";
  html +=     "</div>";
  html +=     "<div class='large-3 medium-3 columns'>";
  html +=       "<a href='https://twitter.com/" + user.screen_name + "'><h4 class='user-name-text'" + user.link_color + ">" + user.name + "</h4></a>";
  html +=       "<h4 class='twitter-info-text'>@" + user.screen_name + "</h4>";
  html +=      "</div>";
  html +=      "<div class='large-3 medium-3 columns'>";
  html +=        "<h4 class='twitter-info-text'>Followers: " + user.followers + "</h4>";
  html +=        "<h4 class='twitter-info-text'>Following: " + user.following + "</h4>";
  html +=        "<h4 class='twitter-info-text'>Ratio: " + (user.followers / user.following).toFixed(2) + "</h4>"
  html +=       "</div>"
  html +=       "<div class='large-3 medium-3 columns'>"
  html +=         "<h4 class='twitter-info-text'>Total Tweets: " + user.statuses_count + "</h4>"
  html +=       "</div>"
  html +=   "</div>"
  html +=  "</div>"
  // html += "<div class='row'>"
  // html += "<div id='accordion'>"
  // html += "<h3>Recent Tweets</h3>"
  // html += "<div>"
  // html += "<p>Tweet 1: Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam.</p>"
  // html += "<p>Tweet 2: Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam.</p>"
  // html += "<p>Tweet 3: Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam.</p>"
  // html += "</div>"
  // html += "</div>"
  // html += "</div>"
  html +=   "</div>"
    $('.user-list').append(html);
    $( "#accordion" ).accordion({ collapsible: true });
}

function buildTodo(todoName, todoID) {
  // gets todoTemplate stored in DOM.
  var todoTemplate = $.trim($('#todo_template').html());
  // Creates an jQueryDOMElement from the todoTemplate.
  var $todo = $(todoTemplate);
  // Modifies it's text to use the passed in todoName.
  $todo.find('h2').text(todoName);
  $todo.attr('id', todoID);
  // Returns the jQueryDOMElement to be used elsewhere.
  return $todo;
}

//Create functions to add, remove and complete todos

function addToList(content, todoID) {
  var final_todo = buildTodo(content, todoID);
  $('.todo_list').append(final_todo);
}

function remove(task) {
  $(task).remove();
}

function complete(task) {
  $('.todo#' + task.todo.id).addClass('complete');
}

function addTodo(event) {
  event.preventDefault();
  var todoData = $(this).serialize();
  $.post('/add_todo', todoData )
    .done(function(serverData) {
      console.log("successfully added");
      addToList(serverData.todo.todo_content, serverData.todo.id);
    })
    .fail(function() {
      console.log("add failed");
    });
}

function completeTodo(event) {
  event.preventDefault();
  var contentId = $(this).parents(".todo").attr("id");
  $.ajax({
    url: '/todos/' + contentId,
    type: 'PUT',
    data: {todo: {completed: true}}
  }).done(function(todoData) {
    console.log('todo complete');
    complete(todoData);
  }).fail(function() {
    console.log('todo status failed');
  })
}

function deleteTodo(event) {
  event.preventDefault();
  var contentId = $(this).parents(".todo").attr("id");
  $.ajax({
    url: '/todos/' + contentId,
    type: 'DELETE'
  }).done(function(todoData) {
    console.log('todo deleted');
    remove('#' + contentId);
  }).fail(function() {
    console.log('todo status failed');
  })
}