# -*- coding: utf-8 -*-

require 'my_erb'

class Blog::PostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  # GET /blog/posts
  # GET /blog/posts.json
  def index
    @blog_posts = Blog::Post.order('created_at DESC').all
  end

  # GET /blog/posts/1
  # GET /blog/posts/1.json
  def show
    @crumbs[@blog_post.header]=@blog_post.route
  end

  # GET /blog/posts/new
  def new
    @blog_post = Blog::Post.new
  end

  # GET /blog/posts/1/edit
  def edit
  end

  # POST /blog/posts
  # POST /blog/posts.json
  def create
    @blog_post = Blog::Post.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/posts/1
  # PATCH/PUT /blog/posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/posts/1
  # DELETE /blog/posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = Blog::Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:header, :route, :tag, :page)
    end

    def set_layout_params
      super
      @path=request.path
      @crumbs['Блог']=blog_posts_path
    end
end
