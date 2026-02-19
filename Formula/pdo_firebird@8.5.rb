# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1b3d3e0f83c72d51444f3d5b1473cdd56f5e2a4dd3929ff980c5a040597ad6ca"
    sha256 cellar: :any,                 arm64_sequoia: "2d5ad9efd81bb4863a9bb59f19b621e96f4d1d85550ea21d2b1125e0cbb21466"
    sha256 cellar: :any,                 arm64_sonoma:  "bc7c9410185cc7e948604807a8260cf2cb982dc0838070e4ccdbabe1371b6e12"
    sha256 cellar: :any,                 sonoma:        "fda9da3c5e959c10a4656ad73e249010f965765ce5c0dcc005770f91db968d5d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0a6c4eee2ea52b0345d71fcb06d9b641cf94660519d8700706e2f693722284e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "abe63c5f2568ded609e36477335265c7287116b30c5dc1ee47d5c779ed12eddb"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.3.tar.xz"
  sha256 "ce65725b8af07356b69a6046d21487040b11f2acfde786de38b2bfb712c36eb9"
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
