class PagesController < ApplicationController
  before_filter :find_page, :only=>[:up, :down, :show, :edit, :update, :destroy]

  # It's working!
  # I'am use nested_set scope from Model
  def index
    @pages = Page.nested_set.all
  end

  # JUST TESTING! localhost:3000/pages/native
  # Native nested set rendering
  # Native rendering 10 times faster on page with 100 elements
  # but I don't know how to customize rendered html as I wish
  # Jquery plugin haven't flaxible posibilities to customizing (I think it must! it's on client side) !plz, refactor this if you can!
  # Nested Set Gem haven't flaxible posibilities to customizing too (and I think it shouldn't.  It's on server side)
  def native
    # Some times I need to use reversed Nested Set (for rendering elements as plain list)
    # Can I do this with native rendering helper? Now this issue is open for me.
    @pages = Page.arrange
  end

  # Attention!
  # if you want to use reversed_nested_set scope (see Model)
  # you should replace move_to_right_of with move_to_left_of  
  # and replace move_to_right_of with move_to_left_of
  def restructure
    node_id   = params[:node_id].to_i
    parent_id = params[:parent_id].to_i
    prev_id   = params[:prev_id].to_i
    next_id   = params[:next_id].to_i

    return :text=>"alert('do nothing');" if parent_id.zero? && prev_id.zero? && next_id.zero?

    # havn't prev and next
    # have prev
    # have next
    if prev_id.zero? && next_id.zero?
      Page.find(node_id).move_to_child_of Page.find(parent_id)
    elsif !prev_id.zero?
      Page.find(node_id).move_to_right_of Page.find(prev_id)
    elsif !next_id.zero?
      Page.find(node_id).move_to_left_of Page.find(next_id)
    end

    render(:nothing=>true)
  end

  # nested_set          - up: obj.move_left
  # reversed_nested_set - up: obj.move_right
  def up
    @page.move_left
    flash[:notice] = t('pages.moved_up')
    redirect_to(root_path)
  end

  # nested_set          - down: obj.move_right
  # reversed_nested_set - down: obj.move_left
  def down
    @page.move_right
    flash[:notice] = t('pages.moved_down')
    redirect_to(root_path)
  end

  def show; end

  def new
    @page = Page.new
  end

  def edit; end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to(@page, :notice => 'Page was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to(@page, :notice => 'Page was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @page.destroy
    redirect_to(pages_url)
  end

  protected

  def find_page
    @page = Page.find(params[:id])
  end
end
