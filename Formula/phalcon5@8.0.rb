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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c987e920e2756e750f8675c427f695727302c4fe71ef2abf2e20dd5de94fec8b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8ec32a98325602d2fe592926a28ed64ee286722edd4d8f40221e5bc8109f13cb"
    sha256 cellar: :any_skip_relocation, monterey:       "45fd576d20ad1f64dcfefc20dd26f08b0ed13cadf98c5b8bb7f96521a24fe399"
    sha256 cellar: :any_skip_relocation, big_sur:        "1c6c9a8520d352e5df691cbd37072608c170b265d61166aca6a055c2e08561f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "516e7a7b62750068da79eff8a3515f50757085f3349573b370615e744acce12f"
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
