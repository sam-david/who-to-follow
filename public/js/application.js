$(document).ready(function() {
  bindEvents();
});


function bindEvents() {
  // Bind functions which add, remove, and complete todos to the appropriate
  // elements
  $('form').on('submit', addTodo);
  $('.todo_list').on('click', '.complete', completeTodo);
  $('.todo_list').on('click', '.delete', deleteTodo);
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