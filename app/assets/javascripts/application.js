//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .
$(window).ready(function(){
    $("#add_like").submit(function(e){
        $.ajax({
            type: "POST",
            url: "/books/<%= @book.id %>/likes/",
            data: { 'user_id': $('user_id').val(), 'book_id': $('book_id').val() }
        })
    });
});