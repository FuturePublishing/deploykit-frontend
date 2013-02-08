require 'logger'

class Logwrite
    def initialize(logger, type)
        @log = logger
        @type = type
    end 
    def write(message)
        if @type == "stderr"
            @log.error(message)
        elsif @type == "stdout"
            @log.info(message)
        end 
        return message.bytesize
    end 
    alias puts write
    alias print write
    alias p write
end
