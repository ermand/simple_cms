class Page < ActiveRecord::Base

  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  acts_as_list :scope => :subject

  before_validation :add_default_permalink
  after_save :touch_subject

  validates :name, :presence => true, :length => {:maximum => 255}
  validates :permalink, :presence => true, :length => {:maximum => 255}, :uniqueness => true
  # for unique values by subject use ":scope => :subject_id"

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("pages.position ASC") }
  scope :newest_first, lambda { order("pages.created_at ASC") }

  private

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{id}-#{name.parameterize}"
    end
  end

  def touch_subject
    # touch is similar to:
    # subject.update_attribute(:updated_at, Time.now)
    subject.touch
  end

end
