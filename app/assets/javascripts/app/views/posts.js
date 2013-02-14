Blog.Views.posts = Backbone.View.extend({
  el: '.fn-posts-container',

  events: {
    'click .fn-like'          : 'likePost',
    'click .fn-unlike'        : 'unlikePost',
    'click .fn-show-post'     : 'showPost',
    'keyup .fn-comment-text'  : 'postComment'
  },

  initialize: function(){
  },

  likePost: function(e){
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
  },
  
  unlikePost: function(e){
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
  },

  showPost: function(e){
    var postId = $(e.target).parent().parent().find('.fn-id').val(),
        request = $.ajax({ url: '/posts/' + postId, type: 'GET' });

    request.done(function(response){
      var modal = $('.fn-post-modal'),
          commentsList = modal.find('.fn-comments');
      modal.modal('show');
      modal.find('.fn-title').html(response.post.title);
      modal.find('.fn-content').html(response.post.content);
      modal.find('.fn-post-id').val(response.post.id);
      modal.find('.fn-author').attr('href', '/authors/' + response.post.author.id);
      modal.find('.fn-author').html(response.post.author.username);
      commentsList.empty();
      $.each(response.post.comments, function(index,comment){
        commentsList.append('<li><a href="/authors/' + comment.userid + '" target="blank">' + comment.username + '</a> ' + comment.comment + '</li><br />');
      });
    });
  },
  
  postComment: function(e){
    if (e.keyCode == 13) {
      var commentText = $(e.currentTarget).val(),
          postId = $(e.currentTarget).parent().parent().find('.fn-post-id').val(),
          commentsList = $(e.currentTarget).parent().parent().find('.fn-comments'),
          comment = new Blog.Models.comment({post_id: postId, comment: commentText}),
          request = comment.save();

      request.done(function(response){
        console.log(comment);
        console.log(response);
        console.log(e);
        $(e.currentTarget).val('');
        commentsList.append('<li><a href="/authors/"' + response.id + ' target="blank">' + response.username + '</a> ' + response.comment + '</li><br />');
      })
      request.error( function(e){
        $(e.currentTarget).parent().parent().find('.fn-error').html(response.message);
      });
    }
  }
});
