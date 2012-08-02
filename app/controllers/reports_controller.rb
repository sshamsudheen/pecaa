class ReportsController < ApplicationController

  layout 'features', :except => [:orders_report, :search]

  def index
  end

  def graph_index
  end
  
  def new
    render :layout => false
  end
  
  def show_all_products
  end
  
  def show_custom_fields
    
  end
  
  def show_inventory_details
    
  end

  # GET /orders/orders_report
  def orders_report
    @orders = Order.all

    render :layout=> 'pecaa_application'
  end

  def search
    # checking date-placed range
    _dp_range = {}
    if params[:date_placed] == 'on'
      _date_placed = 'created_at >= :date_placed_from AND created_at <= :date_placed_to'
      _dp_range = {:date_placed_from=>Date.strptime(params[:date_placed_from],'%Y-%m-%d')}
      _dp_range.merge!({:date_placed_to=>Date.strptime(params[:date_placed_to],'%Y-%m-%d')})
    end

    if params[:query].blank?
      # by default get all the sites
      @orders = _date_placed.nil? ? Order.all : Order.where("#{_date_placed}", _dp_range)
    elsif params[:search_on] = 'status'
      search_on = 'ship_status LIKE :q' + (_date_placed.nil? ? '' : ' AND '+_date_placed)
      q = {:q=>"%#{params[:query]}%"}
      q.merge!(_dp_range)
      #logger.info "search_on #{search_on}"
      #logger.info "search_on - q #{q.inspect}"
      # now query it
      @orders = Order.where("#{search_on}", q)
    end

    if !params[:query].blank?
      if params[:search_on] = 'website' or params[:search_on] = 'ordered-by'
        @orders = _date_placed.nil? ? Order.all : Order.where("#{_date_placed}", _dp_range)
      end
    end
    # now time to render the view
    render :action => 'orders_report', :layout=> 'pecaa_application'
  end
end
