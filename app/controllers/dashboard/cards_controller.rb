class Dashboard::CardsController < Dashboard::DashboardController
  
  before_filter :setup_menu

  def setup_menu
    gon.menu_active_accordian = 'account'
    gon.menu_active_link = 'cards'
  end
  
  
  add_breadcrumb "Cards", :dashboard_cards_path
  def index
    @cards = current_account.cards.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end


  def show
    add_breadcrumb "Showing Card", dashboard_card_path
    @card = current_account.cards.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  def new
    add_breadcrumb "Creating New Card", new_dashboard_card_path
    @card = current_account.cards.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end


  def edit
    add_breadcrumb "Updating Card", edit_dashboard_card_path
    @card = current_account.cards.find(params[:id])
  end


  def create

    @card = current_account.cards.new(params[:card])

    respond_to do |format|
      if @card.save
        
        if @card.default
      
          @cards = current_account.cards.all
      
          @cards.each do |card|
            if card.default
              card.default = false
              card.save
            end
          end
          @card.default = true
          @card.save
          
        end
        
        
             
        format.html { redirect_to dashboard_cards_path, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @card = current_account.cards.find(params[:id])
    
    # if @card.number != params[:card][:number]
    # 
    #   credit_card = ActiveMerchant::Billing::CreditCard.new(params[:card])
    #   
    #   if !credit_card.valid?
    #     render action: "edit"
    #   end
    # end

    if @card.update_attributes(params[:card])
        
        if @card.default == true
      
          @cards = current_account.cards.all
      
          @cards.each do |card|
            if card.id != @card.id
              if card.default
                card.default = false
                card.save
              end
            end
          end

        end
        
        redirect_to dashboard_cards_path, notice: 'Card was successfully updated.'
        

    else
      render action: "edit"
    end

  end


  def destroy
    @card = current_account.cards.find(params[:id])
    if !@card.default
      @card.destroy
    end

    respond_to do |format|
      format.html { redirect_to dashboard_cards_path }
      format.json { head :no_content }
    end
  end
end
