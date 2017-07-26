require 'net/smtp'
require 'resolv'

module MailVerifier
  class << self

    # Entry point.
    def verify(origin_email, dest_email)
      @origin_email  = origin_email # Some servers require a real mail as "from" to check for destination mails.
      @dest_email    = dest_email
      @dest_domain   = dest_email.split("@")[1]
      @origin_domain = @origin_email.split("@")[1]
      @servers       = list_mxs @dest_domain
      @smtp          = nil

      raise NoMailServerException.new("No mail server for #{@dest_email}") if @servers.empty?
      verify!
    end

    def verify!
      connect
      self.mailfrom @origin_email
      self.rcptto(@dest_email).tap do
        close_connection
      end
    end

    def list_mxs(domain)
      return [] unless domain
      mxs = []
      res = Resolv::DNS.new.getresources(domain, Resolv::DNS::Resource::IN::MX)

      raise NoMailServerException.new("#{domain} does not exist") if res == []

      res.each do |resource|
        mxs << { priority: resource.preference, address: resource.exchange.to_s }
      end
      mxs.sort_by { |mx| mx[:priority] }
    end

    def is_connected
      !@smtp.nil?
    end

    def connect
      begin
        server = next_server
        raise OutOfMailServersException.new("Unable to connect to any one of mail servers for #{@dest_email}") if server.nil?
        @smtp = Net::SMTP.start server[:address], 25, @origin_domain
        return true
      rescue OutOfMailServersException => e
        raise OutOfMailServersException, e.message
      rescue => e
        retry
      end
    end

    def next_server
      @servers.shift
    end

    def close_connection
      @smtp.finish if @smtp && @smtp.started?
    end

    def mailfrom(address)
      ensure_connected

      ensure_250 @smtp.mailfrom(address)
    end

    def rcptto(address)
      ensure_connected

      begin
        ensure_250 @smtp.rcptto(address)
      rescue => e
        if e.message[/^550/]
          return false
        else
          raise FailureException.new(e.message)
        end
      end
    end

    def ensure_connected
      raise NotConnectedException.new("You have to connect first") if @smtp.nil?
    end

    def ensure_250(smtp_return)
      if smtp_return.status.to_i == 250
        return true
      else
        raise FailureException.new "Mail server responded with #{smtp_return.status} when we were expecting 250"
      end
    end
  end

end
