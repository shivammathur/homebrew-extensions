# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "93ca8d276f64573c6b90463ccd6a0cf4d53b97881280e0a7bfca57088a168fbe"
    sha256 cellar: :any_skip_relocation, big_sur:       "51dbaa63b5bb5bc342e66f150ece0113054f7d19185363e7fd83a110693cb654"
    sha256 cellar: :any_skip_relocation, catalina:      "225caec58c570a1b8f327c819323e843125249bed24437a712247b6c5896cfd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c59eb6c7726cae3f169c0c10d06c04ce8047bad0ade5eebfbc5bb58568efae85"
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
