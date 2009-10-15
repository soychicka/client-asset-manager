class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name :string, :unique
    email_address :email_address, :login => true
    administrator :boolean, :default => false
    timestamps
  end
  has_many :task_assignments, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :tasks, :through => :task_assignments
  has_many :projects, :class_name => "Project", :foreign_key => "owner_id"
  has_many :project_memberships, :dependent => :destroy
  has_many :joined_projects, :through => :project_memberships, :source => :project

  # This gives admin rights to the first sign-up.
  # Just remove it if you don't want that
  before_create { |user| user.administrator = true if RAILS_ENV != "test" && count == 0 }
  
  
  # --- Signup lifecycle --- #

  lifecycle do

    state :active, :default => true
    create :signup, :available_to => "Guest",
           :params => [:name, :email_address, :password, :password_confirmation],
	   :become => :active

    transition :request_password_reset, { :active => :active }, :new_key => true do
    UserMailer.deliver_activation(self, lifecycle.key) if user.blank?
   end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end
  

  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    acting_user.administrator? || (acting_user == self && only_changed?(:crypted_password, :email_address))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end