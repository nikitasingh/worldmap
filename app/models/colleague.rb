class Colleague < ActiveRecord::Base
  attr_accessible :location, :name, :project, :latitude, :longitude, :longlat

  attr_accessible :email, :role, :contactnum

  attr_accessible :attachment

  attr_accessor :attachment,:longlat

has_attached_file :attachment, :default_url => "../../../system/colleagues/attachments/small/missing.png",:styles => {
    :thumb=> "100x100#",
    :small  => "150x150>",
    :medium => "300x300>",
    :large =>   "400x400>" }


end
