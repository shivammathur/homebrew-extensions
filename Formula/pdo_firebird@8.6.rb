# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/14624997bbb5dffa6b47dc5e9b2e16b22e1f5b54.tar.gz?commit=14624997bbb5dffa6b47dc5e9b2e16b22e1f5b54"
  version "8.6.0"
  sha256 "b00bdf793aec825cc04873db41c3dcca32b1f28c16aac3b22087c537befe6af8"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "08a24bff4986f4f63456c0b317a04c22c165ef7fc88baca816cd51aed2a75c31"
    sha256 cellar: :any,                 arm64_sequoia: "765da7c28e704b9f63e3b20c4096a91fdffc00e6ec016e6b78b47293659b09de"
    sha256 cellar: :any,                 arm64_sonoma:  "c733e11ad72bee221eedc12a97479e6a7801ff746368a1353db5c20f56717f73"
    sha256 cellar: :any,                 sonoma:        "d9b0ae3c438db7bcff68ca797de18604d5df29ce12560ae888bb7aa4775d2c5e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f442220a8de01aef0a1794b56078beb2663fb9d191a79f6e2f6f3dbe63c1d4cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82ed142dcb698bd4197207aed78f87fdae9dca0ea906f00a200788b7664afd4c"
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
