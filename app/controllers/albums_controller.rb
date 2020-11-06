class AlbumsController < ApplicationController
  before_action :set_album, except: [:remove_connection]
  before_action :set_user_list, only: [:add_to_list, :remove_from_list]

  def show
  end

  def edit_connections
  end

  def edit_tags
    @tags = @album.tags.sort_by(&:text)
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
    ActiveRecord::Base.transaction do
      AlbumConnection.where(
        parent_album_id: params[:connected_album_id],
        child_album_id: params[:album_id],
        user_id: current_user.id
      ).destroy_all

      AlbumConnection.where(
        parent_album_id: params[:album_id],
        child_album_id: params[:connected_album_id],
        user_id: current_user.id
      ).destroy_all
    end

    respond_to do |format|
      format.js
    end
  end

  def add_tag
    previous_tags_size = @album.tags.size

    ActiveRecord::Base.transaction do
      @album.save! if @album.new_record?
      params["tags"]["text"].split(",").map do |new_tag|
        AlbumTag.find_or_create_by(
          tag_id: Tag.find_or_create_by(text: new_tag.strip.titlecase).id,
          album_id: @album.id,
          user_id: current_user.id
        )
      end
    end

    @tags = @album.tags.sort_by(&:text)
    @tags_were_added = @tags.size > previous_tags_size

    respond_to do |format|
      format.js
    end
  end

  def remove_tag
    AlbumTag.where(
      album_id: @album.id,
      tag_id: params["tag_id"],
      user_id: current_user.id
    ).destroy_all

    @album.reload
    @tags = @album.tags.sort_by(&:text)

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
