class Authentication < ApplicationRecord
	has_secure_password
	belongs_to :user

	def sign_in
    update(access_token: add_token)
  end

  def sign_in_with_account_social(token)
    update(access_token: add_token(token))
  end

  def add_token(token = generate_access_token)
    _new_tokens = self.access_token
    _new_tokens.shift() if _new_tokens.length >= 2
    _new_tokens.push(token)
    _new_tokens
  end

  def generate_access_token
    SecureRandom.urlsafe_base64
  end

  def generate_confirm_token
    update_attributes(confirm_token: generate_access_token, confirm_send_at: Time.now)
  end

  def confirm_token_valid?
    (self.confirm_send_at + 10.minutes) > Time.now
  end

  def confirmed_email
    self.confirm_token = nil
    self.confirm_at = Time.now
  end

  def access_token
    JSON.parse(self[:access_token])["tokens"]
  end

  def access_token=(value)
    self[:access_token] = { tokens: value }.to_json
  end

  def remove_token(token)
    new_tokens = self.access_token
    new_tokens.delete(token).present? ? update(access_token: new_tokens) : false
  end

  # Sign in with facebook

  def self.find_or_create_account_social(provider, uid)
    Authentication.find_or_initialize_by(provider: provider, uid: uid)
  end

  def self.create_user_with_account_social(authSocial, avatar)
    User.create(
      avatar: avatar,
      name: authSocial['name']
    )
  end

  def self.sign_in_with_account_social(access_token, provider, uid, authSocial, avatar)
    _auth = find_or_create_account_social(provider, uid)
    if _auth.id.present?
      _auth.sign_in_with_account_social(access_token)
    else
      ActiveRecord::Base.transaction do
        user = create_user_with_account_social(authSocial, avatar)
        _auth.update(
          access_token: [access_token],
          user_id: user.id,
          provider: provider,
          uid: uid,
          password: 'no password'
        )
      end
    end
    _auth
  end
end
