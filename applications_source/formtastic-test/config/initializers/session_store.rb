# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_formtastic-test_session',
  :secret      => '394c5280667270db72414bd74d17be4943621336f46721044da498f2da1fe7a38835e67fe1e8fbd900c7ef90ef5101fd5bac9fdd54f334a3536edb1adb1ec013'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
