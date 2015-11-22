class SftpHelper

  def self.upload_content!(full_file_path, content, remote_path)
    File.open(full_file_path, 'w') { |f| f.write content }

    connect do |sftp|
      sftp.upload!(full_file_path, remote_path)
    end
  end

  def self.download!(remote_path, local_path)
    connect do |sftp|
      sftp.download!(remote_path, local_path)
    end
  end

  def self.remove!(file_path)
    connect do |sftp|
      sftp.remove!(file_path)
    end
  end

  def self.get_entries(path)
    connect do |sftp|
      sftp.dir.entries(path)
    end
  end

  def self.connect
    #TODO: put this confs in a .yml file
    #
    sftp_server = if Rails.env == 'production'
                    'csv.example.com/endpoint/'
                  else
                    '0.0.0.0:2020'
                  end
    result = nil

    Net::SFTP.start(sftp_server, "some-ftp-user", :keys => ["path-to-credentials"]) do |sftp|
      result = yield(sftp)
    end

    result
  end
end
