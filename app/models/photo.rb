class Photo < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    image_filename :string
    image_width    :integer
    image_height   :integer
    image_name     :string
    image_author   :string
    timestamps
  end

  acts_as_fleximage :image_directory => 'public/images/uploaded_photos'


  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
