class AddFormsController < ApplicationController
  layout "add_form"
  def new
  end

  def create
    question_detail = params[:add_form][:question_detail]
    @add_form = AddForm.new(params[:add_forms])
    @add_form.questions = question_detail.split(';').collect do |q|
      if q.split('+').last == "text_field_question"
        TextQuestion.new(:name => q.split('+').first,:type => TextQuestion, :field_type =>"text_field") if q.split('+').first
      elsif q.split('+').last == "single_selection_question"
        SingleOptionQuestion.new(:name => q.split('+').first,:type => SingleOptionQuestion, :field_type =>"select") if q.split('+').first
      elsif q.split('+').last == "text_area_question"
        TextQuestion.new(:name => q.split('+').first,:type => TextQuestion, :field_type =>"text_area") if q.split('+').first
      elsif q.split('+').last == "radio_button_choise_question"
        SingleOptionQuestion.new(:name => q.split('+').first,:type => SingleOptionQuestion, :field_type =>"radio_button") if q.split('+').first
      elsif q.split('+').last and q.split('+').last.split('---').first == "multiple_choice_question"
        options = q.split('+').last.split('---').last.split('seperatoruiui').collect{|a| Option.new(:name=> a) unless a.blank?}.compact
        MultipleOptionQuestion.new(:name => q.split('+').first,:type => MultipleOptionQuestion, :field_type =>"check_box", :options=>options) if q.split('+').first
      end
    end.compact
    respond_to do |format|
      AddForm.transaction do
        if @add_form.save
           ContentLibrary.create({:name => @add_form.name,
          :source_id => @add_form.id, :source_type => 'AddForm',
          :last_used => nil, :times_used => nil, :added_by => current_user.username})
          format.html { redirect_to content_libraries_path }
          format.json { render json: @add_form, status: :created, location: @add_form }
        else
          format.html { render action: "new" }
          format.json { render json: @add_form.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def question_detail
     respond_to do |format|
      format.html { render :partial => "question_detail"} # show.html.erb
      format.json { render :json => @text }
    end
  end
end
