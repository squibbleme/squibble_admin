module Squibble::Mongoid::Tree::TouchParent
  extend ActiveSupport::Concern

  def self.included(base)

    # Sind :parent Objekte vorhanden, so wird auf diesen ein :touch
    # ausgeführt, wenn die :resource selbst gespeichert oder ein
    # :touch ausgeführt wird.
    #
    base.after_touch do
      self.parent.touch if self.parent.present?
    end

    base.after_save do
      self.parent.touch if self.parent.present?
    end

  end
end
