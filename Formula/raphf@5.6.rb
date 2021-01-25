# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT56 < AbstractPhp56Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-1.1.2.tgz"
  sha256 "d35a49672e72d0e03751385e0b8fed02aededcacc5e3ec27c98a5849720483a7"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "a5d24a8f7d53e4ab02d69c74a106ffdd1ac6f8ee71fa733fdcb137f3d5bc7332" => :big_sur
    sha256 "e7797c0c43c1f7a12e1de5a44a7c049d49f550bec9cf4a04adab9e969ef8e940" => :arm64_big_sur
    sha256 "06e552f187a8519541e3fcc3f7cfe91f359f2b062e99468d64f11976ab2f84e4" => :catalina
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
