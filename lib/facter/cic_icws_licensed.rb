def key_exists?(path_reg)
  begin
    Win32::Registry::HKEY_LOCAL_MACHINE.open(path_reg, ::Win32::Registry::KEY_READ | 0x100 )
    return true
  rescue
    return false
  end
end

def readkey(path_reg,value)
  Win32::Registry::HKEY_LOCAL_MACHINE.open(path_reg,Win32::Registry::Constants::KEY_READ | 0x100) do |reg|
    begin
      regkey = reg[value]
      return true
    rescue
      return false
    end
  end
end

Facter.add(:cic_icws_licensed) do
  confine :osfamily => "Windows"
  setcode do
    require 'win32/registry'
    cic_site_name = readkey('SOFTWARE\Wow6432Node\Interactive Intelligence\EIC\Directory Services\Root', 'SITE')
    cic_icws_licensed = key_exists?('SOFTWARE\Wow6432Node\Interactive Intelligence\EIC\Directory Services\Root\\' + cic_site_name[0] + '\Production\Licenses\I3_FEATURE_ICWS_SDK')
  end
end
