module WorkRateHelper

  def reset_session_ranking
    session[:ranking] = nil if session[:ranking].present?
  end

  def check_zero_whether_first_decimal(score)
    /(\d+)\.0/ === score.to_s
  end

  def set_work_count(count)
    session[:work_count] = count
  end

  def reset_work_count
    session[:work_count] = nil if session[:request_count].present? && session[:request_count] != 0
  end
end
