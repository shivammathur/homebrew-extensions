# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "7b7fc551b97659b8aa2cfbb0b1fbde458bdad56e2280d73e139237549b0eb9e9"
    sha256                               arm64_sequoia: "764c97f93e468c1ea4e5ec1968d313adba97c8c8a794b973a2ac4af340a1e01e"
    sha256                               arm64_sonoma:  "ab1089744e56d5e7678bad7cad1bb2936c64a50f281f8f1488ba0514344c5f8d"
    sha256 cellar: :any_skip_relocation, sonoma:        "316a676ca7d5defaf33db4fe4228d7646530268d90ac8bf1922ecb024fc0e839"
    sha256                               arm64_linux:   "935821d43717f0d8356f04a81967199174b0f882b4e6fc6df3946cf58226f191"
    sha256                               x86_64_linux:  "e16d9ae5878e801cd06ec6ff22db40c2fbd6d9fb836a8286f2fd6bf233ab6934"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
