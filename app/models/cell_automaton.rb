class CellAutomaton < ActiveRecord::Base
  belongs_to :user
  has_many :cells, -> { order(:id) }, :dependent => :destroy
  accepts_nested_attributes_for :cells, allow_destroy: true

  after_destroy :delete_file
  def delete_file
    File.delete("#{self.id}.rb")
  end

  validates :name, presence: true
  validates :board_size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :step, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :state_num, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :neighbor_rule, presence: true
end
