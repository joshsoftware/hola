class Contact < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  validates :name,:company,:tag_list,presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def self.import(file,user_id)
    error_output= []
    CSV.foreach(file.path, headers: true).with_index  do |row|
      contact = Contact.find_or_create_by(email: row['email'], user_id: user_id)
      tags = CSV.parse_line(row['conference'], col_sep: ' ')
      if contact.persisted?
        contact.tag_list.add(tags)
        contact.save
      else
        unless contact.update_attributes(:name => row["name"],:company => row["company"], :tag_list => [row["conference"]],user_id: user_id)
          row = [row["name"], row["email"], row["company"], row["conference"], contact.errors.full_messages.map(&:inspect).join(",")]
          p contact.errors.full_messages.map(&:inspect).join(",")
          error_output << row
          p error_output
        end
      end
    end
    print_errors(error_output)
  end

  def self.print_errors(error_output)
    attributes = %w{Name Email Company Conference}
    CSV.open(Rails.root.join('public', "file.csv"),"wb") do |csv|
      csv << attributes
      error_output.each do |message|
        csv << message 
      end
    end
  end
end



