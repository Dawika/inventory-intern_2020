class ExpenseTag < ApplicationRecord
  has_many :expense_items

  def self.search(keyword)
    if keyword.present?
      where("name ILIKE ? ", "%#{keyword}%")
    else
      all
    end
  end

  def tag_tree
    SiteConfig.get_cache.expense_tag_tree_hash
  end

  def related_tag_ids
    ids = []
    lv = tag_tree.find{|tt| tt[:id] == self.id }[:lv]
    lv_count = lv
    tag_tree.reverse_each do |tt|
      if ((lv_count == lv) && (tt[:id] == self.id))
        ids << tt[:id]
        lv_count += 1
      elsif ((lv_count > lv) && (lv_count == tt[:lv]))
        ids << tt[:id]
        lv_count += 1
      end
    end
    return ids
  end

  def is_leaf
    lv = 0
    tag_tree.each do |tt|
      if lv > 0
        return lv > tt[:lv] ? false : true
      end
      lv = tt[:lv] if lv == 0 && tt[:id] == self.id
    end
    return true
  end

  def level
    return tag_tree.find{|tt| tt[:id] == self.id }[:lv]
  end

  def parent
    tree = tag_tree
    result = []
    return tree.first if self[:id] == tree.first[:id]
    tree.each do |t|
      result << t and next if result.blank?
      if result.last[:lv] < t[:lv]
        (1..t[:lv] - result.last[:lv]).each do |e|
          result.pop
        end
        result.pop
      elsif result.last[:lv] == t[:lv]
        result.pop
      end
      result << t
      break if self[:id] == t[:id]
    end
    return result.pluck(:id)
  end

  def as_json(options={})
    {
      name: self.name,
      ids: self.related_tag_ids,
      id: self.id,
      is_leaf: self.is_leaf,
      lv: self.level,
      description: self.description
    }
  end
end
