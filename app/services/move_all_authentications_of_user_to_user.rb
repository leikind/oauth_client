module MoveAllAuthenticationsOfUserToUser

  module_function

  def move(from_user, to_user)
    from_user.authentications.each do |authentication|
      auth_uid = authentication['uid']
      auth_type = authentication['type']
      MoveAuthentication.move(from_user, to_user, auth_type, auth_uid)
    end

    from_user.destroy
    UpdateUserAuthentications.update(to_user)
  end
end
