require 'pg_lock'

module ActiveJob
  module Locking
    module Adapters
      class PgLock < Base
        def create_lock_manager
          ::PgLock.new(ttl: self.options.lock_time, name: self.key, attempts: 3, attempt_interval: 5)
        end

        def lock
          self.create_lock_manager.create
        end

        def unlock
          self.create_lock_manager.delete
        end
      end
    end
  end
end
