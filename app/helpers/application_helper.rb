module ApplicationHelper
  def styleguide_block(section, &block)
    raise ArgumentError, "Missing block" unless block_given?


    @section = @styleguide.section(section)
    content = capture(&block)
    render 'dev/shared/styleguide_block', :section => @section, :example_html => content
  end
  
  def cards_total
    current_account.cards.length
  end
  
  def transactions_total
    current_account.transactions.length
  end
  
end