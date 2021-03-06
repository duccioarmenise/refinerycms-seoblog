module Refinery
  module Blog
    module ControllerHelper

      protected

        def find_blog_post
          unless (@post = Refinery::Blog::Post.with_globalize.friendly.find(params[:slug])).try(:live?)
            if refinery_user? and current_refinery_user.authorized_plugins.include?("refinerycms_seoblog")
              @post = Refinery::Blog::Post.friendly.find(params[:slug])
            else
              error_404
            end
          end
        end

        def find_all_blog_posts
          @posts = Refinery::Blog::Post.live.includes(:category).with_globalize.newest_first.page(params[:page])
        end

        def find_tags
          @tags = Refinery::Blog::Post.live.tag_counts_on(:tags)
        end

        def find_all_blog_categories
          @categories = Refinery::Blog::Category.translated
        end
    end
  end
end
