# -*- encoding: utf-8 -*-
require 'pop3_client'

class ApiController < ApplicationController
  skip_before_filter :authenticate_auth!
  before_filter :api_auth_required, :except => [:error]

  def api_auth_required
    if logged_in?
      return true
    elsif params[:login] == 'goldrush' && params[:password] == 'furuponpon'
      return true
    else
      redirect_to :action => :error
      return false
    end
  end

  def error
    render :text => 'REQUEST ERROR!!'
  end

  #-----------------------------------------------------------------------------
  # API Start
  #-----------------------------------------------------------------------------

  # SESî•ñƒ[ƒ‹‚ðŽæ‚èž‚Þˆ—‚ðŒÄ‚Ño‚·
  def import_mail_pop3
    ImportMail.import
    render :text => 'REQUEST OK!'
  end
  
  # ƒ[ƒ‹Žæ‚èž‚Ý‹@”\
  #   POSTFIX‚È‚Ç‚ð—˜—p‚µ‚Äƒ[ƒ‹ƒeƒLƒXƒg‚ðPOST‚µ‚Ä‚à‚ç‚¤
  def import_mail
    src = params[:mail]
    # ƒ[ƒ‹ƒeƒLƒXƒg
    ImportMail.import_mail(Mail.new(src), src)
    render :text => 'REQUEST OK!'
  end
  
  def broadcast_mail(test)
    # targets = DeliveryMailTarget.find(:all, :conditions=>["delivery_mail_id=?", params[:id])
    targets = DeliveryMailTarget.find(:all, :conditions=>["delivery_mail_id=?", test])
    target_ids = targets.map{|t| t.bp_pic_id}
    
    # 送信先アドレスを取得
    destinations = target_ids.map {|i| 
      bp_pic = BpPic.find(i)
      bp_pic.email1
    }
    
    # メール送信
    # DeliveryMail.send_mails(params[:id], destinations)
    DeliveryMail.send_mails(test, destinations)
    
    # render :text => 'REQUEST OK!'
    p "REQUEST OK!"
  end
  
end
