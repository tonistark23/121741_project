class MoneyCalculator

attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :sum

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    @ones = ones.to_i
    @fives = fives.to_i
    @tens = tens.to_i
    @twenties = twenties.to_i
    @fifties = fifties.to_i
    @hundreds = hundreds.to_i
    @five_hundreds = five_hundreds.to_i
    @thousands = thousands.to_i
    @sum = @ones+(@fives*5)+(@tens*10)+(@twenties*20)+(@fifties*50)+(@hundreds*100)+(@five_hundreds*500)+(@thousands*1000)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
  end
  
  def change(price)	  	

  	res = @sum.to_i - price.to_i
  	@res = res
  	@ones = 0
  	@fives = 0
    @tens = 0
    @twenties = 0
    @fifties = 0
    @hundreds = 0
    @five_hundreds = 0
    @thousands = 0
  	
 	
  	
		while (res != 0)
			if (res%5 == 0 and res%10 != 0 and res%20 != 0 and res%50 != 0 and res%100 !=0 and res%500 != 0 and res%1000 != 0)
				@fives +=1
				res = res- 5
			elsif (res%10 == 0 and res%20 != 0 and res%50 != 0 and res%100 !=0 and res%500 != 0 and res%1000 != 0)
				@tens+=1
				res = res - 10	
			elsif (res%20 == 0 and res%50 != 0 and res%100 !=0 and res%500 != 0 and res%1000 != 0)
				@twenties+=1
				res = res - 20
			elsif (res%50 == 0 and res%100 !=0 and res%500 != 0 and res%1000 != 0)
				@fifties+=1 
				res = res -50
			elsif (res%100 == 0 and res%500 != 0 and res%1000 != 0)
				@hundreds+=1
				res =res - 100
			elsif (res%500 == 0 and res%1000 != 0)
				@five_hundreds+=1
				res = res - 500
			elsif res%1000 == 0
				@thousands +=1
				res = res - 1000
			else
				@ones+=1
				res-=1
			end
	  end

  hsh = {
  :ones =>@ones,
  :fives => @fives,
  :tens => @tens,
  :twenties => @twenties,
  :fifties => @fifties,
  :hundreds => @hundreds,
  :five_hundreds => @five_hundreds,
  :thousands =>@thousands }

=begin
hsh = {
  :ones => 0
  :fives => 0
  :tens => 0
  :twenties => 0
  :fifties => 0
  :hundreds => 0
  :five_hundreds => 0
  :thousands => 0 }
=end

	"Your change is:
	  #{hsh[:ones]} one/s, 
	  #{hsh[:fives]} five/s, 
	  #{hsh[:tens]} ten/s, 
	  #{hsh[:twenties]} twenty/ies, 
	  #{hsh[:fifties]} fifty/ies, 
	  #{hsh[:hundreds]} hundred/s, 
	  #{hsh[:five_hundreds]} five hundred/s, and
	  #{hsh[:thousands]} thousand/s. "	
  
  #hsh.each_pair { |key, value| puts "#{key}.to_s : #{value}"}
  
  end  
  
  def give_sum
  	  	"#{@sum}"
  end
  

  
end   
