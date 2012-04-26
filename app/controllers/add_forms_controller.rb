class AddFormsController < ApplicationController
  layout "add_form"
  def new
  end

  def question_detail
     respond_to do |format|
      format.html { render :partial => "question_detail"} # show.html.erb
      format.json { render :json => @text }
    end
  end
end
