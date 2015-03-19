class CriticalSection

  def self.by key, &block
    fd = File.open("/tmp/cs_domain_checker_#{key}.lock", File::RDWR | File::CREAT, 0644)
    if fd.flock(File::LOCK_EX | File::LOCK_NB)
      begin
        yield block
      rescue Exception => e
        raise e
      ensure
        fd.close
      end
    else
      raise "Another instance of #{key} is processing"
    end
  end

end