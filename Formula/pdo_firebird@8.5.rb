# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "bffea1f19f358ea920a0d53c2d276becb8cd0ce01cc444ef62e0e0ec104d8f58"
    sha256 cellar: :any,                 arm64_sequoia: "eafcd0e97eac91bfd0a51786ad77b084c17e8c305c127be462b7b445c738289c"
    sha256 cellar: :any,                 arm64_sonoma:  "106dec02095fb5465514e8af02e9ef7d45c759286efe8f2c603258bb94926f78"
    sha256 cellar: :any,                 sonoma:        "1d2af5b9a46069bed33e48e4cd92049fd1ae77474e2e209ab1db42d125df6944"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "893776bba54e7f676cc402d4fa164b26f4c0d625ca95a568d4fc150ba273cd3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58fced84533ce9718cab18973166afd2cb88e34ee07979ef2ed8efe15758d53b"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.4.tar.xz"
  sha256 "c1569f1f543f6b025c583cdc0e730e5c5833c603618613f1aa8e75d1524b8c91"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.5.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
