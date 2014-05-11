require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
if params[:name].empty? == true || params[:price].empty? == true || params[:quantity].empty? == true || params[:price].to_i < 0 || params[:quantity].to_i < 0 #assuming price and quantity can be 0 (free or not yet in stock)
	erb :error
else
  Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
  redirect to '/admin'
  end
end

get '/edit_product/:id' do
  begin #[1] RUBY EXCEPTIONS
	  @product = Item.find(params[:id])
	  erb :product_form
  rescue
	  erb :error
  end
end

post '/update_product/:id' do
  begin
	  @product = Item.find(params[:id])
  rescue
	  erb :error
  else
	  if params[:name].empty? == true || params[:price].empty? == true || params[:quantity].empty? == true || params[:price].to_i < 0 || params[:quantity].to_i < 0 #assuming price and quantity can be 0 (free or not yet in stock)
		erb :error
      else
		@product.update_attributes!(
		name: params[:name],
		price: params[:price],
		quantity: params[:quantity],
     	  )
     	redirect to '/admin'
     end
  end
end

get '/delete_product/:id' do
	begin
	  @product = Item.find(params[:id])
	  @product.destroy!
	  redirect to '/admin'
    rescue
	  erb :error
    end
end
# ROUTES FOR ADMIN SECTION

#ROUTES FOR HOMEPAGE SECTION

get '/' do
	@products = Item.all
	@random = @products.sample(10) #[2] Britt, J and Neurogami
	erb :home
end

get '/products' do
	@products = Item.all
	erb :products
end

get '/about' do
	erb :about
end	

get '/purchase_product/:id' do 
	begin
		@product = Item.find(params[:id]) #debug for amt > quantity. nothing negative
		erb :purchase
	rescue
		erb :error
	end
end

post '/purchase_product/:id' do 
		if params[:id].empty? == true || params[:ones].empty? == true || params[:fives].empty? == true || params[:tens].empty? == true || params[:twenties].empty? == true || params[:fifties].empty? == true || params[:hundreds].empty? == true || params[:five_hundreds].empty? == true || params[:thousands].empty? == true || params[:ones].to_i < 0 || params[:fives].to_i < 0 || params[:tens].to_i < 0 || params[:twenties].to_i < 0 || params[:fifties].to_i < 0 || params[:hundreds].to_i < 0 || params[:five_hundreds].to_i < 0 || params[:thousands].to_i < 0 ||  (params[:ones].to_i == 0 && params[:fives].to_i == 0 && params[:tens].to_i == 0 && params[:twenties].to_i == 0 && params[:fifties].to_i == 0 && params[:hundreds].to_i == 0 && params[:five_hundreds].to_i == 0 && params[:thousands].to_i == 0)
			erb :error
		else
			@product = Item.find(params[:id]) 
			@qSold = params[:amount].to_i
			@calculator = MoneyCalculator.new(params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands])
			@change = @calculator.change(@product.price * @qSold) #[6] CUA, KEVIN
			if @calculator.give_sum.to_i < (@qSold * @product.price)
				erb :error
			else
				@product.update_attributes!( #compute for total price sold
				name: @product.name,
				price: @product.price,
				quantity: @product.quantity - params[:amount].to_i,
				sold: @product.sold.to_i + params[:amount].to_i,
			  )	
			  erb :tempo
		end
	end
end
	

#ROUTES FOR HOMEPAGE SECTION