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
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1d015eb9f9f83922831d522416e5c016d2713bd18984ae6024203a45f18d44f5"
    sha256 cellar: :any_skip_relocation, big_sur:       "69cc57c5d46601c7fc34cffa7e508fdbcbfb19c32073ce2ebd6c203090d3128a"
    sha256 cellar: :any_skip_relocation, catalina:      "4cdebc5c2c6a0bae45f50f07f01a403af160a55b158605f71fe3211e1029a8f8"
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
