class AlbumsController < ApplicationController
  before_action :set_album
  before_action :set_user_list, only: [:add_to_list, :remove_from_list]

  def show
  end

  def edit_connections
  end

  def edit_tags
  end

  def edit_lists
  end

  def add_connection
    AlbumConnection.create!(
      parent_album_id: @album.id,
      child_album_id: params[:child_album_id],
      user_id: current_user.id
    )

    respond_to do |format|
      format.js
    end
  end

  def remove_connection
    AlbumConnection.where(
      parent_id: params[:connected_album_id],
      child_id: @album.id,
      user_id: current_user.id
    ).destroy_all

    AlbumConnection.where(
      parent_id: @album.id,
      child_id: params[:connected_album_id],
      user_id: current_user.id
    ).destroy_all

    respond_to do |format|
      format.js
    end
  end

  def add_tag
    AlbumTag.create!(
      tag_id: Tag.find_or_create_by(text: params[:tag][:text]).id,
      album_id: @album.id,
      user_id: current_user.id
    )

    respond_to do |format|
      format.js
    end
  end

  def remove_tag
    AlbumTag.where(
      album_id: @album.id,
      tag_id: params[:id],
      user_id: current_user.id
    ).destroy_all

    respond_to do |format|
      format.js
    end
  end

  def add_to_list
    if @user_list.present?
      AlbumList.create!(album_id: @album.id, list_id: @user_list.list_id)
    end

    respond_to do |format|
      format.js
    end
  end

  def remove_from_list
    if @user_list.present?
      AlbumList.where(album_id: @album.id, list_id: @user_list.list_id).destroy_all
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_album
    @album = Album.database_or_external(apple_album_id: params[:album_id] || params[:id])
  end

  def set_user_list
    @user_list = UserList.where(list_id: params[:list][:id], user_id: current_user.id, user_role: User::LIST_CREATOR).first
  end
end
