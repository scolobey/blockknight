
class FeedItemValidator < ActiveModel::Validator
  def validate(record)
    blacklist = ["price predictions", "nutsack"]

    blacklist.any? do |phrase|
      if record.title.include?(phrase)
        record.errors.add(:feed_item, "Title contains blacklisted term: #{phrase}")
      end
    end

  end
end
