# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.3.tgz"
  sha256 "fba5fbffb9eeb2296a07c83866a4e02315715dbb93c2b8ea87ab92627de18630"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "98cfe55dc2027dd0694842eb4940b0e312e8fb0d157abb2e4063a4981db31041"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "122ef62a7d053bda1c46bcf16972edd6b7268eee7aa518ec8cbe5cdc2bfd3e66"
    sha256 cellar: :any_skip_relocation, monterey:       "4a009b02f9df41898346c3a69d8ec345087f6968a57f7861a167e90ef3a8f4a9"
    sha256 cellar: :any_skip_relocation, big_sur:        "0dd8ef7a45b60804e214c22b67ca8a2de766424685f94bbea9b1f89a9cbf9757"
    sha256 cellar: :any_skip_relocation, catalina:       "08a05026353d9b5d6a91324ae26e2d4a26c618ab62efea1434e18d25279e2964"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ab55269112699520c3d383eb2a7521186b63f386278526ffebd76ad2dda2ac6b"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
