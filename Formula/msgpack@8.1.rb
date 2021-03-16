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
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bab1a9b8949acb9f68f86aeb1c4315822b6eadfd0fdada8ec8a11b7348947cb1"
    sha256 cellar: :any_skip_relocation, big_sur:       "ea795562812b8df170345ae875b49161ce8fff0a1f81ec8ec1d0943f7c773555"
    sha256 cellar: :any_skip_relocation, catalina:      "1a2ed75208e13cfb1928da2775c38ee11906c0301d535d9ee79875b9469b81f5"
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
