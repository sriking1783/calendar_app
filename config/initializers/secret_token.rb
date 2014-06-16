# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Events::Application.config.secret_key_base = 'fca70d0aa1229a0a932b750639c8a5f9fe114c90aaa452c9dc8645013f769152c1116b2fdb282a38b6801295bcf437533276a90b28dd9c5bb64e17cba7cff77b'
