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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2dbff205f86455c287137dc8e9e567996f58dddc05391500854f6c68f4048750"
    sha256 cellar: :any_skip_relocation, big_sur:       "8b1ce7f45407a83b20c94c7669ebabe2d8e4e452b8ef9e68d3c29faa7a0acf69"
    sha256 cellar: :any_skip_relocation, catalina:      "5225cb5820c9934f1a44f44f4e6485bea26ab927f8987e71b08626a4b247a2b7"
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
