# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "31a98278fa431dbb15ddd0d87bb34e67bbdd2104202b7f058589676bd4f677b5"
    sha256 cellar: :any,                 arm64_sequoia: "6161ce34b9b84e29788eb65b58c448100bc929c9ab427468e046916675ae2f08"
    sha256 cellar: :any,                 arm64_sonoma:  "4171ce85e39fcd6c1efb8d06fc77a78ac9e93b0e46006ff3af5a10d17ce8ff2c"
    sha256 cellar: :any,                 sonoma:        "a6e64b0b3f1bda560f85a10c2e13505693a35bc2b71fa0b55690a0d91057af31"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "276f51e6b44315741da1477b903986f7cbb9fab28ff643e09d2ed3eaa3c328ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40def26cc764b7b37be0cfe3ee9e224c434eb942901e05dc1a6b0f2c6efb51bc"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.18.tar.xz"
  sha256 "957a9b19b4a8e965ee0cc788ca74333bfffaadc206b58611b6cd3cc8b2f40110"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
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
