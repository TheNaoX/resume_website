var Blog = {
  Models: {},
  Collections: {},
  Views: {},
  Templates: {},

  Initialize: function(){
    Blog.router = new Blog.Router();
    Backbone.history.start({pushState: true})
  }
};
