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
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6c66a6cba4a07ddac43f5cac5a26fecbfe30acf0a73940afadfb7996218374d6"
    sha256 cellar: :any_skip_relocation, big_sur:       "c67d73af483658a8342f448e5ad59347fc7ed31190831cad0f3a3fc95cae567e"
    sha256 cellar: :any_skip_relocation, catalina:      "a20b956535e2c0f0959d4c6ca880961cc244b15023ba82915f4e174b5e348938"
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
