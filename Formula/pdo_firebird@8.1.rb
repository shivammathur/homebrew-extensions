# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT81 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ad820425604a1a912f35ff27a34955f961ecd25a926b91c1181b631aae2b8c99"
    sha256 cellar: :any,                 arm64_sequoia: "08a58f3445f36ece1f3cbb4bee4cad17b30f25ca07b8f26b23bb02820953055a"
    sha256 cellar: :any,                 arm64_sonoma:  "f5e0e10359435a63c74b4a3f88a011f801a5dabe1fb87bc91637da584563786c"
    sha256 cellar: :any,                 sonoma:        "cf32e9d6d49b4d584bac3eafc8560033474af521a1d3df4bf553e1bbc3e58bba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bdddf26ab5ffdac26cfadb65e9210660b78acccb2f4532b464b67250492ecaa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "926d6dd66a95b2cb5c1d18fe95427b653f4d02735dacaff6807e897232eed4d7"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  head "https://github.com/php/php-src.git", branch: "PHP-8.1"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
