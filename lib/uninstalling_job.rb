class UninstallingJob < Struct.new(:site)

  # Uninstall its application 
  # Suitable for cleaning its application but not affect to its database.
  def perform

    puts "\n\n\n----------- SITE_DESTROYING -----------\n\n\n"

    puts "PATH = #{site.path}"

    puts "APPNAME=#{site.user_id}_#{site.name}"


    # Drop database
    if system("sh -c 'cd #{site.path}/current/; cap USER=#{site.user.id} APPNAME=#{site.user_id}_#{site.name} database:drop;'")

      site.status = "Drop Database : #{site.user_id}_#{site.name} -----------\n"
      puts "\n----------- Drop Database : #{site.user_id}_#{site.name} -----------\n"

      # Delete all files of its application
      if system("sh -c 'test -e #{site.path}/'")

        site.status = "Delete application files"
        system("sh -c 'rm -Rf #{site.path}'")
        puts "\n----------- Delete #{site.path}   -----------\n"

        # Delete web-server configuration file 
        # stored in deploying tools project [Instant Online Application]
        #remove_subdomain_conf(site) 
        if system("sh -c 'test -e #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")

          system("sh -c 'rm -Rf #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}.*'")
          site.status = "Site was successfully Uninstalled"
          site.save
          puts "\n----------- Delete #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"

          return true

        else
          puts "\n----------- Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name} -----------\n"
          flash[:warning] = "Cannot delete sub-domain the confinguration file --> #{RAILS_ROOT}/site_info/#{site.user.id}_#{site.name}"

          return true 
        end
      else
        puts "\n----------- Cannot delete application root path --> #{site.path}   -----------\n"
        flash[:warning] = "Cannot delete application root path --> #{site.path}"

        return false
      end
    else  
    puts "\n----------- Cannot delete Database : #{site.user.id}_#{site.name} -----------\n"

    return "Cannot delete Database : #{site.user.id}_#{site.name} "

    return false

    end
  end
end
