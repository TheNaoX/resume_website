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
//= require libs/bootstrap
//= require libs/underscore
//= require libs/backbone
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
      var modal = $('.fn-post-modal'),
          commentsList = modal.find('.fn-comments');
      modal.modal('show');
      modal.find('.fn-title').html(response.post.title);
      modal.find('.fn-content').html(response.post.content);
      modal.find('.fn-post-id').val(response.post.id);
      modal.find('.fn-author').attr('href', '/authors/' + response.post.author.post.id);
      modal.find('.fn-author').html(response.post.author.post.username);
      commentsList.empty();
      $.each(response.post.comments, function(index,comment){
        commentsList.append('<li><a href="/authors/' + comment.userid + '" target="blank">' + comment.username + '</a> ' + comment.comment + '</li><br />');
      });
    });
  });

  $(document).on('keyup', '.fn-comment-text', function(e){
    if (e.keyCode == 13) {
      var commentText = $(e.currentTarget).val(),
          postId = $(e.currentTarget).parent().parent().find('.fn-post-id').val(),
          commentsList = $(e.currentTarget).parent().parent().find('.fn-comments'),
          request = $.ajax({ url: '/comments', type: 'POST', data: { post_id: postId, comment: commentText } });
      request.done(function(response){
        $(e.currentTarget).val('');
        if (response.status == 200) {
          commentsList.append('<li><a href="/authors/"' + response.user.id + ' target="blank">' + response.user.username + '</a> ' + response.comment.comment + '</li><br />');
        } else {
          $(e.currentTarget).parent().parent().find('.fn-error').html(response.message);
        }
      });
    }
  });

});
