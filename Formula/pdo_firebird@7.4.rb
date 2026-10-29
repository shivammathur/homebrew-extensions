# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9f3f6763497aa556d3fc56df7e66f44b8de49815.tar.gz"
  version "7.4.33"
  sha256 "cd3e5db449ebad253f678afd3421ffd108d6a3a6bd7ad1d05dc80988b96b015d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "5287875e9c4db73484eece8e5d3696b5e737a1019f3ae7654246ade51c79cbcd"
    sha256 cellar: :any, arm64_tahoe:       "8e22c5118372209b9066e64a7fd612834d186df892bd9f90957bc7f7eb2b94e6"
    sha256 cellar: :any, arm64_sequoia:     "438c14a948be3ed0f3544221f7551849a090e20c27f60cc5f5f16e6997808a27"
    sha256 cellar: :any, arm64_linux:       "29eb85c1d750251f7af266ba874ca51d8aaf4d7fbeb282953098fb8bf3662542"
    sha256 cellar: :any, x86_64_linux:      "082c17eae2cd56862ad5169e337b8d817375faf269119e085c656b3cc57db007"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
