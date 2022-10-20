# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "be14d5f3e93cc029903732f8817b827494707d2085554a265cafd84acb3ea3cd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7e6034d0c1a91a56528acf0288f48703fe65b725276cf334aa8015cd09462966"
    sha256 cellar: :any_skip_relocation, monterey:       "4014e2c32459fed6dc3824e5a408174e54695d93c12e3e46800db182e44282a4"
    sha256 cellar: :any_skip_relocation, big_sur:        "fb2e22f39298bc297a6d8cf0d2fd845da75b12cd57ed1d726e837afac4e91c5c"
    sha256 cellar: :any_skip_relocation, catalina:       "01282064e78afae53c20ffcfcd3beac048e3b408fcc8103577a5451e12f2f856"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3e1fa7f979be720f71d2914a15493ddd3f710efdef3f68170f6ce0f48c3b0ff"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
