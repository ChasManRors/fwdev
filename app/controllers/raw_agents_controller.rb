class RawAgentsController < ApplicationController

  before_filter :authenticate_user!

  def index
    begin
      current_user.update_attributes(:my_last_zip_search => params[:search]) if !params[:search].blank?
      @non_active_record_agents = FeeWise.find_by_zip(params[:search])["agentlist"]
    rescue Exception => e
      @non_active_record_agents = []
      # render "page/non_accessible" and return
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_agents }
    end
  end

  def show
    @my_agent_id = params[:id]
    current_user.update_attributes(:my_last_agent_id => @my_agent_id)

    # @my_agentxbroker = MyAgent.find_agentxbroker_by_agent_id(params[:id])
    # raw_xml = FeeWise.find_agentdata_by_agent_id(params[:id])
    @non_active_record_agent = FeeWise.find_agentdata_by_agent_id(params[:id])

    @agent_name    = @non_active_record_agent["UserInfo"].to_a.map{|x| x.last}.join ' '
    @agent_city    = @non_active_record_agent["Address"]["Office"]["city_name"]
    @agent_state   = @non_active_record_agent["Address"]["Office"]["postal_code"]
    @agent_county_name   = @non_active_record_agent["Address"]["Office"]["county_name"]
    @agent_email   = @non_active_record_agent["Email"]["Public"]["email_address"]
    @agent_phone   = "#{@non_active_record_agent["Phone"]["Office"]["phone_number"]} #{@non_active_record_agent["Phone"]["Office"]["extension"]}"
    @agent_tagline = @non_active_record_agent["Business"]["tagline"]

    # TODO: this needs to be turned into a loop when time permits, looks like there can be many brokers this agent works with
    @broker = @non_active_record_agent["Brokers"].values.first
    @broker_name   = @broker["broker_name"]
    @broker_city   = @broker["city_name"]
    @broker_state  = @broker["state_name"]
    @broker_phone  = @broker["broker_phone"]
    @agent_license = @broker["agentlicense"]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @my_agent }
    end

  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
