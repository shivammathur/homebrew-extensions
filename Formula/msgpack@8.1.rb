# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhp81Extension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9ae92b5d6ef0a5d398c40dbc5d55db1f0cb8bb3b35cb72e3e328e2197ff0c8eb"
    sha256 cellar: :any_skip_relocation, big_sur:       "d5a52188862621f4e466e00ec4c574cddce353a3f377716a165fc7c64c674b24"
    sha256 cellar: :any_skip_relocation, catalina:      "0f9f54bbeb39cd408cb58ee4110ff156eaf64c9ebf1da7d05af579e356825a2d"
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
