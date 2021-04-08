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
    rebuild 9
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "da75825695cf265773cccefd019e6cba5b93b35056b248668a0251a3549c619d"
    sha256 cellar: :any_skip_relocation, big_sur:       "4aab4043aafbdc3b573026eaec5a50b72d7405be2d1bea9ad568a9cc8c2223fa"
    sha256 cellar: :any_skip_relocation, catalina:      "b741c864d39628c2b387a30058b90b7ae15cd430fdfab26f2a01b11d97f1d106"
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
