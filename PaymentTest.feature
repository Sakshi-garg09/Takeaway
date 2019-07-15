@PaymentOptions 
Feature: Payment Option 
  As a user,
  I want to be able to select my payment option so that
  I can pay for the items through my preferred mode or on delivery.
  
  Background:
    Given User is on Add to cart Screen
    And User is logged in
    And User has some items in the cart
    And User proceeds to checkout
    

  @manual 
  Scenario:  "Checkout" button should not be enabled by default if User has less than minimum order value as per restaurent as checkout amount
    Given User has items worth 9 euros in "Add to cart" screen
    """
    Make sure user has items worth minimum order value in Add to cart screen 
    """  
    And minimum order value is equal to 10 euros
    When User navigate to "Add to cart" screen 
    Then "Checkout" button should be disabled on the "Add to cart" screen
    
    
  
  @manual
  Scenario: "Checkout" button should be enable if the user has equal or greater then the value as per restaurant as checkout amount
    Given User has items worth 10 euros in "Add to cart" screen
    And minimum order value as per selected restaurant is equal to 10 euros
    When User navigate to "Add to cart" screen
    Then "Checkout" button should be enabled on the "Add to cart" screen 
   

   @manual
  Scenario: User should be able to select any payment option under "How would you like to pay?"
    Given User is on "Ready to eat ?" screen under "Your order" page
    And All the payment options are given under "How would you like to pay?"
    When User selects one of the payment option under "How would like to pay?"
    Then User should be able to click on "Order and Pay" button
    
    
    
    @manual
  Scenario: User can not be proceed via "credit card" if time is before 10:00 and after 22:50
    Given User is on "Ready to eat ?" screen under "Your order" page
    And All the payment options are given under "How would you like to pay?"
    And Time is 9:00
    When User selects "credit card" as a  payment option under "How would like to pay?"
    And User clicks on "Order and pay" button
    Then "Message" pop up screen is shown which says "Unfortunately, it is not possible to make a credit card payment after 22:50 and before 10:00"
  
  
  
   @manual
  Scenario: User navigate to each listed payment option under "How would you like to pay?" opens the respective payment option as per specification.
    Given User is on "Ready to eat ?" screen under "Your order" page
    And All the payment options are given under "How would you like to pay?"
    When User selects one of the payment option under "How would like to pay?"
    Then User navigate to respective page of payment option as per specification
      
    
    @manual
  Scenario: User should be able to add new card details on "Payment method" page with storing credit card information
    Given User is on "Ready to eat ?" screen under "Your order" page
    When User selects "Credit card" under "How would you like to pay?"
    And User check "Use stored credit card information" checkbox for future use
    And User click on "Order and pay"
    And User selects one of three card type under "Payment method" 
    Then User should be able to enter card details to pay
    

      
    @manual
  Scenario: Check Respective "payment method" selection opens card number, expiry date, Card Holder and CVV option
    Given User is on "Payment Method" screen
    And All "Payment Methods" are visible
    When User selects any one of the "Payment Method"
    Then Respective "Payment method" opens card number, expiry date, Card Holder and CVV option
    And UI of "Enter Details" page should be correct
    
    
    @manual
  Scenario: Check saved card functionality on payment method screen
    Given User is on "Payment Method" screen
    And User has saved card
    When User transacts through saved card
    Then User should be able to do transaction through saved card
    
    
    
    @manual
  Scenario Outline: Check payment failed popup if user cancels transaction during transaction processing
    Given User is on payment method screen
    And Checkout amount is 10 euros
    When User transacts through <transaction_medium>
    And User cancels transaction during transaction processing
    Then "Payment failed" dialog should appear
    And User should navigate to "Ready to eat ?" page once he cancels "payment failed" dialog box
    And Amount should not be debited
    Examples:
      | Transaction_medium |
      | American Express   |
      | MasteCard          |
      | Visa               |    
      
        
      
    @manual
  Scenario: User should be able to details on "Paypal" page with storing paypal information
    Given User is on "Ready to eat ?" screen under "Your order" page
    When User selects "PayPal" under "How would you like to pay?"
    And User check "Remember my PayPal information" checkbox for future use
    And User click on "Order and pay"
    And User navigate to "PayPal" page
    Then User should be able to enter details of "PayPal" account
    
    
    @manual
  Scenario: User can not be proceed via "credit card" if time is before 10:00 and after 22:50
    Given User is on "Ready to eat ?" screen under "Your order" page
    And All the payment options are given under "How would you like to pay?"
    And Time is 9:00
    When User selects "credit card" as a  payment option under "How would like to pay?"
    And User clicks on "Order and pay" button
    Then "Message" pop up screen is shown which says "Unfortunately, it is not possible to make a credit card payment after 22:50 and before 10:00"
      
    
      
    @manual @e2e.android @e2e.ios
  Scenario Outline: Verify no internet connection scenario when user transacts through payment option
    Given User is on "Ready to eat ?" screen
    And User has no internet access
    When User transacts through <payment_option>
    Then No internet screen should be shown
    Examples:
      | Payment_option     |
      | Cash               |
      | PayPal             |
      | Credit card        |
      | Sofort             |
      
      
          
    @manual @e2e.android @e2e.ios
  Scenario: Verify "Stored credit card" functionality
    Given User is on "Ready to eat ?" screen under "Your order" page
    When User selects "Credit card" under "How would you like to pay?"
   """
    User had already stored his credit card information
    """
    And User click on order and pay button
    And user navigate to "Payment method" screen
    When user select any one of the "Payment method" in which details are saved
    Then saved card details should be shown in the "Enter Details" screen
    
    
    
    
    @manual @e2e.android @e2e.ios
  Scenario: Verify "Stored credit card" functionality with multiple cards
    Given User is on payment method screen
    When user select any one of the "Payment method"
    Then User can add new card details or select the saved card details to proceed
    
    
    
    
    @manual @e2e.android @e2e.ios
  Scenario: Verify deleting any "Stored credit card" functionality
    Given User is on payment method screen
    And User select any one the payment method
    And User has saved card in card tab
    When User deletes the saved card details from card tab
    Then Saved card details should be deleted
    
    
    
    
    @manual @e2e.android @e2e.ios
  Scenario: Verify payment failure when user enters wrong CVV for saved card
    Given User is on payment method screen
    And Checkout amount is 10 euros
    When User transacts through any of the payment method
    And User enters wrong CVV in card details
    Then Transaction should not be completed
    
    
    
    
    @manual @deep @e2e.android @e2e.ios @target-payment-api
  Scenario Outline: All payment options should be backend configurable to disable
    Given User is on "Ready to eat ?" screen under "Your order" page
    When <payment_option> is disabled from backend
    Then <payment_option> should be not be visible on App
    Examples:
      | payment_Option  |
      | Cash            |
      | PayPal          |
      | Credit Card     |
      | Sofort          |
      
      
      
   @manual @target-api.cart @target-payment-api
  Scenario Outline: Correct payment mode is set depending upon the chosen payment mode
    Given User is on "Ready to eat ?" screen under "Your order" page
    When the user pays using <payment_option>
    Then mode of Order was <mode_of_order>
    """
    Online & Cash payment mode can be verified through Order detail for that order
    """
    Examples:
      | payment_option   | mode_of_order   |
      | Cash             | Pay on Delivery |
      | PayPal           | Online          |
      | Credit Card      | Online          |
      | Sofort           | Online          |
      
      
      
   @target-api.cart @target-payment-api @m.app.sanity @e2e.android @e2e.io
  Scenario Outline: User transacts using payment option
    Given User is on payment options screen
    And All payment options are visible
    When User selects <payment_option> option
    Then UI of <payment_option> should be correct
    Examples:
      | Payment_option     |
      | Cash               |
      | PayPal             |
      | Credit card        |
      | Sofort             |
      
      
      
  @automated @target-api.cart @target-payment-api @smoke @e2e.android @sanity
  Scenario: User transacts using payment option
  """ 
      | Payment_option     |
      | Cash               |
      | PayPal             |
      | Credit card        |
      | Sofort             |
    """
    Given User is on "Ready to eat ?" screen under "Your order" page
    Then All payment options are visible
    And UI of selected payment option should be correct  
    
    
   @automated @target-api.cart @target-payment-api @smoke @e2e.android @sanity
  Scenario: User successfully transacts using card payment option and place order
  """
      | Payment_option     |
      | Cash               |
      | PayPal             |
      | Credit card        |
      | Sofort             |  
  
  """
    Given User is on payment options screen
    Then All payment options are visible
    And User successfully transact using card payment option
    
    
  
    @manual
  Scenario: User should be able to apply coupon code 
    Given User is on "Ready to eat ?" screen under "Your order" page
    When User enter coupon or voucher code 
    Then coupon code applied successfully
           
           
           
    @manual
  Scenario: Payment option defaults to the paypal option on first time login
    Given User is on "Ready to eat ?" screen under "Your order" page
    And All the payment options are given under "How would you like toP pay?"
    Then Paypal option should be selected by default
    And User can select any one of the payment option as per requirement        
      
