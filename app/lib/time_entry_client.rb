class TimeEntryClient
   class APIError < StandardError; end;

  def initialize(opts={})
    @api_key = opts[:api_key]
    @api_url = opts[:api_url]
    @project_id = opts[:project_id]
    @task_id = opts[:task_id]

    @c = FreshBooks::Client.new(@api_url, @api_key)
  end

  def fetch(opts={})
    entries = []

    result = fetch_time_entry_list(opts)
    raise APIError, result["error"] if result["error"]

    entries += result["time_entries"]["time_entry"]

    # Handle multiple pages
    2.upto(result["time_entries"]["pages"].to_i) do |page|
      entries += fetch_time_entry_list(opts.merge(page: page))["time_entries"]["time_entry"]
    end

    entries
  end

  private

  def fetch_time_entry_list(opts={})
    @c.time_entry.list(opts.merge(project_id: @project_id, task_id: @task_id))
  end
end