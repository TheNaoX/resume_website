// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  $(document).on('click', ".fn-like", function(e){
    var postId = $(e.target).parent().parent().find('.fn-id').val(),
        likeLink = $(e.target).parent().parent().find('.fn-like-link'),
        likeMessageTag = $(e.target).parent().parent().find('.fn-like-message'),
        request = $.ajax({ url: '/posts/like', type: 'POST', data: { post_id: postId } });

    request.done(function(response){
      if (response.status == 200) {
        likeLink.html("<a class='fn-unlike'>Unlike</a>")
        likeMessageTag.html(response.message);
      }
    });
  });

  $(document).on('click', ".fn-unlike", function(e){
    var postId = $(e.target).parent().parent().find('.fn-id').val(),
        likeLink = $(e.target).parent().parent().find('.fn-like-link'),
        likeMessageTag = $(e.target).parent().parent().find('.fn-like-message'),
        request = $.ajax({ url: '/posts/unlike', type: 'POST', data: { post_id: postId } });

    request.done(function(response){
      if (response.status == 200) {
        likeLink.html("<a class='fn-like'>Like</a>")
        likeMessageTag.html(response.message);
      }
    });
  });

  $(document).on('click', '.fn-show-post', function(e){
    var postId = $(e.target).parent().parent().find('.fn-id').val(),
        request = $.ajax({ url: '/posts/' + postId, type: 'GET' });
    request.done(function(response){
      var modal = $('.fn-post-modal');
      modal.modal('show');
      modal.find('.fn-title').html(response.post.title);
      modal.find('.fn-content').html(response.post.content);
      modal.find('.fn-author').attr('href', '/author/' + response.author.id);
      modal.find('.fn-author').html(response.author.username);
    });
  });

});
