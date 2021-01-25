# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT74 < AbstractPhp74Extension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b7dda981b173790ac5c3d1190360a506dacafdf4e84be97cbe7b3043af6ce3f5" => :big_sur
    sha256 "3a9793a4ea6f617a1fd256d8c79895416b2f514cf9d74652787c8d3ef4f2ca44" => :arm64_big_sur
    sha256 "7b92e7c3fcb0836d6fe9d00677590678be6ed0979571cf3bccfce1e4f6b65879" => :catalina
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
