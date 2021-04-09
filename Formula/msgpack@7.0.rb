# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhp70Extension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "036ccde59b09634070df147a6988694f8301c56e2bd89bd6d0e3932197fc3ca8"
    sha256 cellar: :any_skip_relocation, big_sur:       "d179defa7d3918c8dd116bd24f43ebaebf8e1dbc1b7834ffdac6ce0777b0e2af"
    sha256 cellar: :any_skip_relocation, catalina:      "32b959a5daedbe671a0d14361e43a5701af83fd69c1c0ff76ac35b1b6de48ac9"
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
