Blog.Router = Backbone.Router.extend({
  routes: {
    "posts" : "posts"
  },

  posts: function(){
    this.index = new Blog.Views.posts();
  }
});
