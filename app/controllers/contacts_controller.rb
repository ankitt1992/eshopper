class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update]

  def index
    @contacts = Contact.all.order('created_at DESC')
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        AdminMailer.contact_email(@contact).deliver_now
        format.html { redirect_to @contact }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        UserMailer.reply_email(@contact).deliver
        format.html { redirect_to contacts_path, notice: 'Email has been sent to the user.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message, :reply)
    end
end
