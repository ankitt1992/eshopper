Rails.configuration.stripe = {
  # :publishable_key => Rails.application.secrets.stripe_publishable_key,
  # :secret_key      => Rails.application.secrets.stripe_secret_key
  :publishable_key => 'pk_test_nvfBbtZh1Bpvi7IfLcQr899o',
  :secret_key      => 'sk_test_Op95kXVX0UO6rIPqBq1MfxHI'
}

# Stripe.api_key = Rails.application.secrets.stripe_secret_key
Stripe.api_key = Rails.configuration.stripe[:secret_key]