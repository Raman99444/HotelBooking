class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_booking, only: [:show, :edit, :update, :destroy]
    layout 'dashboard'
  
    def my_bookings
      @bookings = current_user.bookings || []
      respond_to do |format|
        format.html
        format.json { render json: @bookings }
      end
    end
  
    def new
      @booking = Booking.new
      respond_to do |format|
        format.html
        format.json { render json: @booking }
      end
    end
  
    def create
      @booking = current_user.bookings.new(booking_params)
      respond_to do |format|
        if @booking.save
          format.html { redirect_to my_bookings_path, notice: 'Booking created successfully' }
          format.json { render json: @booking, status: :created }
        else
          format.html { render :new }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def edit
        respond_to do |format|
            format.html
            format.json { render json: @booking }
        end
    end
  
    def update
        respond_to do |format|
          if @booking.update(booking_params)
            format.html { redirect_to my_bookings_path, notice: 'Booking updated successfully' }
            format.json { render json: @booking, status: :ok }
          else
            format.html { render :edit }
            format.json { render json: @booking.errors, status: :unprocessable_entity }
          end
        end
      end
  
    def destroy
      @booking.destroy
      respond_to do |format|
        format.html { redirect_to my_bookings_path, notice: 'Booking deleted successfully' }
        format.json { head :no_content }
      end
    end
  
    private
  
    def set_booking
      @booking = current_user.bookings.find(params[:id])
    end
  
    def booking_params
      params.require(:booking).permit(:hotel_name, :price, :currency, :arrival_date, :departure_date, :guest_name, :guest_email)
    end
  end
  