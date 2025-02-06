class DashboardController < ApplicationController
  def index
    @recent_notes = current_user.notes.order(updated_at: :desc).limit(5)
    @pending_tasks = current_user.tasks.where(status: 'pending').limit(5)
    @recent_wiki_pages = WikiPage.order(updated_at: :desc).limit(5)
  end
end 