class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_booking, only: [:show, :edit, :update, :destroy]
    layout 'dashboard'
  
    def my_bookings
      @bookings = current_user.bookings || []
    end
  
    def new
      @booking = Booking.new
    end
  
    def create
      @booking = current_user.bookings.new(booking_params)
      if @booking.save
        redirect_to my_bookings_path, notice: 'Booking created successfully'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @booking.update(booking_params)
        redirect_to my_bookings_path, notice: 'Booking updated successfully'
      else
        render :edit
      end
    end
  
    def destroy
        puts @booking
      @booking.destroy
      redirect_to my_bookings_path, notice: 'Booking deleted successfully'
    end
  
    private
  
    def set_booking
      @booking = current_user.bookings.find(params[:id])
    end
  
    def booking_params
      params.require(:booking).permit(:hotel_name, :price, :currency, :arrival_date, :departure_date, :guest_name, :guest_email)
    end
  end
  