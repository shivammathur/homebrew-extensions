# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhp80Extension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2ca6480764648caf4ef005ccba9120302bd1294255cfc86bb1870f59d1e1be30"
    sha256 cellar: :any_skip_relocation, big_sur:       "ab6469058258bea16d3edd3b48dab0caa15d3dcb475fef796f922e7ae8306284"
    sha256 cellar: :any_skip_relocation, catalina:      "9ad2dfb4f9bf48f860ab69136f82da520e26d2c64e2e625e047a3a99dfcaa6d3"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
