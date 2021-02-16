# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhp71Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "ff3c4d66eed4334c497121aab8d72096219b9eb2663ea09b371d16adee1b7dc7" => :big_sur
    sha256 "afce5082a3cf67e54fb481e6ac2c41147c4a7c207b81353c6104a908269c445c" => :arm64_big_sur
    sha256 "0a637b2a936102aebf8211ef91f58d8b996398242ea7fd0bb834e9465c4fac87" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
