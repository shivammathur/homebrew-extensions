# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/ce7896d514b415922b344f58f45471c01de6d4a3.tar.gz?commit=ce7896d514b415922b344f58f45471c01de6d4a3"
  version "8.6.0"
  sha256 "8c6e7f7e79cb7093a4d2873ae9bfdd92735ce1c17dd0ea570fc22d8100e3f838"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any, arm64_tahoe:   "4cac1ca848db06413eb370c8a2034a252605ee78aa8effb2d5115879e73de283"
    sha256 cellar: :any, arm64_sequoia: "0f7fe13b07373821acfe14422d98c0634ad9eb271f7cc2893f455347cf715362"
    sha256 cellar: :any, arm64_sonoma:  "4219f73b3b18044ed5c30e18fc33a4a97afa56a0af138386791279f29c64c6b2"
    sha256 cellar: :any, arm64_linux:   "c16ba36f54c5f3bfefd0dccc35edee52c93f10d0e1f22fc21ba9ad0a50bc1b32"
    sha256 cellar: :any, x86_64_linux:  "8bee3b4ea7c41ef163d2ab71c000546703768531e255d35539acc9bc0582ea8f"
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
