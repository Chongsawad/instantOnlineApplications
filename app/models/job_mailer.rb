class JobMailer < ActionMailer::Base

  def mail_waiting 
    recipients  "chongsawad252@gmail.com"
    from        "chongsawad252@gmail.com"
    subject     "Wait for deploying method"
    body        "Deploying method began at : #{DateTime.now}" 
  end

  def mail_finished 
    recipients  "chongsawad252@gmail.com"
    from        "chongsawad252@gmail.com"
    subject     "Finished deploying method" 
    body        "Deploying method finished at : #{DateTime.now}" 
  end

end
