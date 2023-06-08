# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "66a196a29f8f564478039db591c7199370e9fa2a8a954a6d9883055d16a9d23c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "42360c2d8652e29c06ac9f9dbd445bdbf124feecc91dd95ad5835b5280e2d8b4"
    sha256 cellar: :any_skip_relocation, ventura:        "7d9d496721c9af2a3c20cde4b371b2feb4741b083365d05e16bd008ac4839a01"
    sha256 cellar: :any_skip_relocation, monterey:       "1ae1decf14bd330829154d11effc7772bc150a4fff6b95b228a07da722ef5e25"
    sha256 cellar: :any_skip_relocation, big_sur:        "8fdad3e50928455921fff01c8e8c8ee18da17b187b7ef10ce438c3691e037452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74ddb9efe0ef14702318ae045ae5c2de3e8a65ea39ebb4f5b5c71a0434f72045"
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
