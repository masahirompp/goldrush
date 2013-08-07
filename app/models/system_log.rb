# -*- encoding: utf-8 -*-
class SystemLog < ActiveRecord::Base
  include AutoTypeName

  def SystemLog.put(type, code, title, contents, user, sub_type = nil, tags = [])
    SystemLog.new({
      :log_code => code,
      :log_title => title,
      :log_contents => contents,
      :log_type => type,
      :log_sub_type => sub_type,
      :log_tag1 => tags[0],
      :log_tag2 => tags[1],
      :log_tag3 => tags[2],
      :created_user => user,
      :updated_user => user
    }).save!
  end

  def SystemLog.error(code, title, contents, user, sub_type = nil, tags = [])
    SystemLog.put('error', code, title, contents, user, sub_type, tags)
  end

  def SystemLog.info(code, title, contents, user, sub_type = nil, tags = [])
    SystemLog.put('info', code, title, contents, user, sub_type, tags)
  end

  def SystemLog.warn(code, title, contents, user, sub_type = nil, tags = [])
    SystemLog.put('warn', code, title, contents, user, sub_type, tags)
  end
end
