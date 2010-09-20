class CleaningJob < Struct.new(:site)

  # Uninstall its application 
  # Suitable for cleaning its application but not affect to its database.
  def perform
    if system("sh -c 'cd #{site.path}/current/; cap APPNAME='#{site.user.id}_#{site.name}' USER=#{site.user.id} AUTO_ACCEPT='true' OVERWRITE='true' database:remigrate;'")
      site.status = "Online"
      site.save
      return true

    else 
      site.status = "Cannot clean database"
      site.save
      return false
    end
    
  end
end
