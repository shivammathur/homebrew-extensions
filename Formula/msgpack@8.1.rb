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
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "58a40f7e0ce453217e40f6103f7e97d80b1706346bac7a59eef424411761c929"
    sha256 cellar: :any_skip_relocation, big_sur:       "8150be926560b11c6646dd160c0f5333d0a3e7d56807a63567d1484f9d222a9e"
    sha256 cellar: :any_skip_relocation, catalina:      "dc6d49dd1a0783d4195614a5441fb83e4b1091e6101fef9e6ec16a1b7411d572"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
