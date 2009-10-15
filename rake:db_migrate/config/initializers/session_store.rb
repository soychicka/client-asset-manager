# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rake:db_migrate_session',
  :secret      => 'd490dcf4f8609f9cbbcdefbb0132f6d82dea2345ae0f944a75271c01b641b661b58450b60c9908d15ba284cb603b8e41262007d5e67e7f71a48368e9ed2f4aae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
