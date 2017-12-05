class VacationProfileWidget
  include ActiveSupport::Benchmarkable

  # To display the vacation widget a freshbooks api key is required to be set for the user
  # But the max hours field is optional and it will just display some extra UI features if it is present

  def self.configured_for(opts = {})
    user = opts[:user]
    if user && user.freshbooks_api_key.present?
      self.new(api_url: "brandnewbox.freshbooks.com", api_key: user.freshbooks_api_key, max_hours: user.max_vacation_hours)
    else
      nil
    end
  end

  attr_reader :max_hours

  def initialize(opts = {})
    @project_id = 13 # BNB
    @task_id = 38 # Vacation
    @api_url = opts[:api_url]
    @api_key = opts[:api_key]
    @max_hours = opts[:max_hours]

    @client = TimeEntryClient.new(api_url: @api_url, api_key: @api_key, project_id: @project_id, task_id: @task_id)
  end

  def hours
    @hours ||= begin
      current_year = Date.today.year
      time_entries = benchmark("Freshbooks hours fetch") { @client.fetch(date_from: "#{current_year}-01-01", date_to: "#{current_year}-12-31") }
      total = time_entries.map { |t| t["hours"].to_f }.reduce(:+)
      total
    rescue
      0
    end
  end

  def days
    hours / 8
  end

  def max_days
    return if max_hours.nil?
    max_hours / 8
  end

  def vacation_used_percentage
    return if max_hours.nil?
    "#{(hours / max_hours) * 100}%"
  end

  def to_partial_path
    "profile_widgets/vacation"
  end

  private

  def logger
    Rails.logger
  end
end