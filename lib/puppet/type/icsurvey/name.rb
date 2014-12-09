newparam(:name) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::String

  desc "icsurvey's name "

  isnamevar

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('name')
  end

end
