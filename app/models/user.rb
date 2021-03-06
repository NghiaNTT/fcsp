class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :education_posts, class_name: Education::Post.name
  has_many :education_socials, class_name: Education::Social.name
  has_many :education_comments, class_name: Education::Comment.name
  has_many :education_rates, class_name: Education::Rate.name
  has_many :education_project_members, class_name: Education::ProjectMember.name
  has_many :course_members, class_name: Education::CourseMember.name
  has_many :education_courses, through: :course_members, source: :course
  has_many :education_projects, through: :education_project_members,
    source: :project
  has_many :education_user_groups, class_name: Education::UserGroup.name
  has_many :education_groups, class_name: Education::Group.name,
    through: :education_user_groups, source: :group
  has_one :education_program_member, class_name: Education::ProgramMember.name
  has_one :education_learning_program, through: :education_program_member
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :images, as: :imageable, dependent: :destroy
  has_many :education_images, class_name: Education::Image.name,
    as: :imageable, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  enum role: [:user, :admin]

  after_create :create_user_group

  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true

  scope :not_in_course, ->course do
    where("id NOT IN (?)", course.users.pluck(:user_id)) if course.users.any?
  end

  private

  def create_user_group
    self.user_groups.create
  end
end
