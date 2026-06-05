# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.22.tar.xz"
  sha256 "696c0f6ad92e94c59059c1eb6e300842b8d050934226efcdf00f2a413cb083cf"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8a115e0618ae000a7022264190f1fa3a48dfe97d0e328f884b49f52ffe1948a3"
    sha256 cellar: :any,                 arm64_sequoia: "5464fbd2b88404e3e50583e1e62315a0c11d679df469b55e559f8b855ac0b500"
    sha256 cellar: :any,                 arm64_sonoma:  "d763fca077a8cc1a359b0e5cd7f3ac68b2920a4de69a15dce45e923fd2e16f12"
    sha256 cellar: :any,                 sonoma:        "7a14247a3a1d6074c769a0211c7222ee26a69e6c1965e8acd054789e39c5c33c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "08ff0c750f5a9a3b9b69cf94ec41e3c31f91fd3125693a58aa07ee41ee1ef97b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64352017107d1311f1b5f989db5822d61051b34592872b78187e436e0dbec193"
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
