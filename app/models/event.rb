class Event < ApplicationRecord
  has_many :rsvps, dependent: :destroy
  has_many :members, through: :rsvps

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  scope :published, -> { where(published: true) }
  scope :upcoming, -> { where("starts_at >= ?", Time.current.beginning_of_day).order(:starts_at) }
  scope :past, -> { where("starts_at < ?", Time.current.beginning_of_day).order(starts_at: :desc) }

  def to_param
    slug
  end

  def past?
    starts_at < Time.current.beginning_of_day
  end

  def today?
    starts_at.to_date == Date.current
  end

  def attending_count
    rsvps.yes.count
  end

  def spots_remaining
    return nil unless capacity
    [ capacity - attending_count, 0 ].max
  end

  def full?
    capacity.present? && attending_count >= capacity
  end

  private

  def generate_slug
    return if slug.present?
    base = title.to_s.parameterize
    self.slug = base
    counter = 2
    while Event.exists?(slug: self.slug)
      self.slug = "#{base}-#{counter}"
      counter += 1
    end
  end
end
