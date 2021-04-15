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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cff7f9e65d88f7b2a26853641db5cd3966f1d7259ecf8657aeb832b2977aa5fd"
    sha256 cellar: :any_skip_relocation, big_sur:       "56d84a0e7d17cdfe4b6609a7201d49d671d6accb5d6f9977bc779ca8b2ec9efb"
    sha256 cellar: :any_skip_relocation, catalina:      "3e4c4680315136aebc529e46ac6ec0d457024a92700e1772033a64cf06665d54"
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
