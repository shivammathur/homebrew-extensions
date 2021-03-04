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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b41db40674c36ecca54f400a85c861dc04f93292864e128d82dbd8871abf89d4"
    sha256 cellar: :any_skip_relocation, big_sur:       "3f176b1d57dc1a875accac39189ab0f1f10226810b48c1ba8de72231c7435d9a"
    sha256 cellar: :any_skip_relocation, catalina:      "6f78f41c2807ed4fe21847046b2f9222cbd5e5eb523bbfaa717f955b2c633b87"
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
