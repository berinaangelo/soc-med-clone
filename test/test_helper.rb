ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Parallel workers each get their own MySQL test database (test-0, test-1, ...), created/
    # dropped per run — with a shared MySQL server (not sqlite's throwaway per-file DBs) that's a
    # real risk of clobbering the wrong database. Pinned to 1 worker, no parallelization.
    parallelize(workers: 1)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
