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
    rebuild 6
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e24ef6d29fe97d00e690bcfee15f97a883bbb29bebd78c88542ea18260c96716"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "59050d4a944afc48b56d7c9d5fefec7dadd9cbb4544ba36b3355e8a2aa47f061"
    sha256 cellar: :any_skip_relocation, monterey:       "30aa1b43d8547d7d2950ed3f361a33efff439e82e30298d7763ddae0128f6b34"
    sha256 cellar: :any_skip_relocation, big_sur:        "54dce36ac4f818110358be24c90c240e1fde6812a2f8d05c49732d35e003b79c"
    sha256 cellar: :any_skip_relocation, catalina:       "e6bf0b0aaacda18bc3818d526c3059921fc22184e9e54af37b5c322dc4a4d0a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8ac5c3b356ab6649d3ae1a8c404f64df7e67aaf31025a67c8208fdce852e2de"
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
