# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT84 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "34037bafbf934ce43a70adade81d0503651b02101024687525d714afe6cfe15d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8c65bfc92ed99db6f3c0850a79ac4082e2bf287a85e12a4bf41a05e27d0d5277"
    sha256 cellar: :any_skip_relocation, ventura:        "673ebab0bc0be6c2c70a6b4449152cce127f3a78517e404432d5854d281edc82"
    sha256 cellar: :any_skip_relocation, monterey:       "ec3c44d8f4b8a1f40f1aba6950042a43aaa4c1476d4f5c64873354efb06478a6"
    sha256 cellar: :any_skip_relocation, big_sur:        "94c28fd493c7ac46f4f1ae8dc7eeeef5e4f3132d5bcff2e6022dd069710d0616"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49fca35f05f45da98643b26917014203db029dc16f547b027ccbfb8e0b1faa8c"
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
