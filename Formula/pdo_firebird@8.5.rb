# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "02bb7cfb57a63d845e7f9944e49c48aa8830b99d088921ee0c8b5b088195dc6e"
    sha256 cellar: :any,                 arm64_sequoia: "3b804e0879273e8726277b39e9de4bdea6762259e8b0a830a8e1c020eecb9b19"
    sha256 cellar: :any,                 arm64_sonoma:  "0288b0f99538c55a15877de884a18c588c8bf0adc1c445f7a6e724a76a9184bd"
    sha256 cellar: :any,                 sonoma:        "dd4f744f1e0726772c243f61ab03a875f11d013eb676c76daa0a6e6fa19dfb9d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7e299bb1d31f88c776865de10550c815b58494979338eb06d10cd11d6d87a406"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9335c834088c4c3c44b3d747d872fad7bd408ebc7a5a7f98bacf62f334670a40"
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
