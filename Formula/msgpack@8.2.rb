# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b1873780299a17dd0529e690968157cd10c664a2efc21bcb770bc53dc1cf0a95"
    sha256 cellar: :any_skip_relocation, big_sur:       "d0b7c11532b6195c311c1411365aff293be59f9456862fb684c1223abecb0df0"
    sha256 cellar: :any_skip_relocation, catalina:      "d270424da04012543ac1849718b4306b15dd943f621a6488883bb3c7cc415406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42951bcc734a9c4b4c1f8dcf7e7729d7b5bbf25ebc484a47e5edda3b67ca7a20"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
