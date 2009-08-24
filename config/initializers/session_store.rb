# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kk_session',
  :secret      => '3abc87685c9db1a4c2a8160496f5e308618c8de55c3640f85cc3db0ab81baa76f043ed122d690978c8d0cde65475cdc9feb480190196f3d00a8989baf43ec845'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
