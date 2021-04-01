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
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "83b73fee1302c4717e2e30d91439d3d217a2fe8e91373947f6a03d69842a619b"
    sha256 cellar: :any_skip_relocation, big_sur:       "e4d7bfd716498c1dca9f4e07496dbd771c65de7cb9f075322e09d63b9086499e"
    sha256 cellar: :any_skip_relocation, catalina:      "2ddbc59077e88ff17e9662a29837bd745274abdc22960e064ba650db747aee38"
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
