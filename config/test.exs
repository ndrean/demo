import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :demo, DemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "d6rF9nOntNkZQW+37RqqItQVYH7Nc6uOuE5ZUNpCTWIUjFgXx/5nDEYf9iL4KElc",
  server: false

# In test we don't send emails.
config :demo, Demo.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
