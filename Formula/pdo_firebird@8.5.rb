# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.11.tar.xz"
  sha256 "d9be75c08e8c316f4c8f4194d8fbe1750a15f6a6d9d4e3fe72082abeeb800360"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4cd0930ad4aa597a2e90c1ac704f73e028720d1d829e14e244c5f4fb54297c0c"
    sha256 cellar: :any, arm64_tahoe:       "d729d0280a7ca8fd3c7c8c5b0fe22ee67ad4123fb943ad4d016bd41a00850841"
    sha256 cellar: :any, arm64_sequoia:     "ccc1ce24fdd62f0b7271efb1728a8f5308e6833d77a834a42bed555b8c899582"
    sha256 cellar: :any, arm64_linux:       "341e263800e1a3388d190be88e7a71d919be9675bc5529b7c6d560f35bfce44c"
    sha256 cellar: :any, x86_64_linux:      "8f0b0ee7546e022170b443e5332f31c419e10274b94d52b65d8f978574e4bd13"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
