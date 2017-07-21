class SignaturesController < ApplicationController
  def index
    @signature = Signature.all
  end
  def new
    @signature = Signature.new
  end
  def create
    @signature = Signature.new(signature_params)
    @contact = Contact.first
     if @signature.save
        SignatureMailer.test_email(@contact.id, @signature.id).deliver_now
        redirect_to signatures_path
      else
        render :new
      end
    end
    def update
    @signature = Signature.find(params[:id])
    if @signature.update_attributes(movie_params)
      redirect_to signatures_path
    else
      render :new
    end 
  end
    def signature_params
      params.require(:signature).permit(:name,:email,:address,:password,:port,:user_name,:smtp_mail_server)
    end
 
end
