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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/msgpack@8.2-2.2.0RC1"
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32c38b11bb935293e76414f7d6f6d7516774b1da12a454471d9b0864f3a559a3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c5427a9554bc4a98d529eb55a9dcbed1f286dde5b52f490c4c5c3233593b4f86"
    sha256 cellar: :any_skip_relocation, monterey:       "c82a3712c8eea9207e32f932d74ed6b43f6024d396a8aaaa4c90ddf8b79146b9"
    sha256 cellar: :any_skip_relocation, big_sur:        "66ccd8a94dc2583c41180dc41356cfd31f67b3f4b921dfb1f32fe1ebc6969f91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e784c655e1bb61c6781a9f89d8f96f96ae05dccd2066676baf79cc0c3587befb"
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
