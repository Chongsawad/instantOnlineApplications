# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_instantOnlineApplicaitons_session',
  :secret      => '2d23b1d949160c8cf33aca58b8451797591268e8e7ed46f2dfae8fb59f8a4bbdf58a0d2e3dbc9d317849a83ccc492592d952793a8b151e018e0d21d3ac468fca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
