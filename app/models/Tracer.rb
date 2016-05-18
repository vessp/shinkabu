class Tracer

    def self.d(message=nil)
        @my_log ||= Logger.new("#{Rails.root}/log/tracer.log")
        @my_log.debug(message)
        puts message
    end

    def self.i(message=nil)
        @my_log ||= Logger.new("#{Rails.root}/log/tracer.log")
        @my_log.info(message)
    end

    def self.w(message=nil)
        @my_log ||= Logger.new("#{Rails.root}/log/tracer.log")
        @my_log.warn(message)
    end

    def self.e(message=nil)
        @my_log ||= Logger.new("#{Rails.root}/log/tracer.log")
        @my_log.error(message)
    end

    def self.f(message=nil)
        @my_log ||= Logger.new("#{Rails.root}/log/tracer.log")
        @my_log.fatal(message)
    end
end