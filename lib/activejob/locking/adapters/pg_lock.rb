require 'pg_lock'

module ActiveJob
  module Locking
    module Adapters
      class PgLock < Base
        def lock_manager
          ::PgLock.new(ttl: self.options.lock_time, name: self.key, attempts: 3, attempt_interval: 5)
        end

        def lock
          self.lock_manager.create
        end

        def unlock
          self.lock_manager.delete
        end
      end
    end
  end
end
