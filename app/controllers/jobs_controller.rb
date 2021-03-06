class JobsController < ApplicationController
  load_and_authorize_resource

  def index
    @jobs = Job.newest.includes(:images).page(params[:page])
      .per Settings.jobs.per_page
  end

  def show
    @job_object = Supports::ShowJob.new @job
  end
end
