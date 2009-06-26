# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_securo-admin_session',
  :secret      => '309b97aef5a9d565bc6022e6bbc8840a1ea69d4890131bb3e66f35e59e688d8d9a4ab53e922abeef1cbe4e621d6840607f30a6005be9bbceb6a179cf96ac1e2e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
