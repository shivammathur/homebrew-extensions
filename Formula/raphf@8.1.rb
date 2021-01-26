# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhp81Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "e88eeddd1d2b7fbd1d8b35cc3e6d66eecc6d8a1665363bcdb84f6599b9c5c203" => :big_sur
    sha256 "2524d75d6430c40c50fcc6dc2e5faa343a6d205629b1f69b9041ed20d77cdb87" => :arm64_big_sur
    sha256 "fb6d5a29ef441d2e0b1c990422ad174e3e2ed3f5e732e3e8c1a1587e44578f84" => :catalina
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
