# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "d6db2852d4b587e2ac192dc7bc901e22e9935a3f2db9bfc5af95bf13b67e6ed2"
    sha256 cellar: :any,                 arm64_sonoma:   "d8d42bf958fdd89ec85e52930a69fd682d0dba3dffe54c2a9b77e3ff91dc1036"
    sha256 cellar: :any,                 arm64_ventura:  "f5ebd714fbde0fc0430732e478ca9b91f21b2a8d905d0385b64e6ee31f775fbd"
    sha256 cellar: :any,                 arm64_monterey: "df3a9ea8c735345d835e17a3b7f8663de7cc1ecbac18f552798e2789c5231e14"
    sha256 cellar: :any,                 ventura:        "4001cffb1ce05e4413cb874deada2c6fd67183f82739bfa6709cbfe4b85a2615"
    sha256 cellar: :any,                 monterey:       "2dff0355f15be143b975ee7c6812d0b1fa9ae8da6733f402b9d0deee2f05f32f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fa6191138be4b276d87bf2e20a8bcd0f2334f3a055d8232c0709a91b86e4a479"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
