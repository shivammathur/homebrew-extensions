# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.4.tar.gz"
  sha256 "30a70eca00d0acaf4979ee532143aebe11cb325a5356b086f357cc3f69fe5550"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9bea92a8032f9fee2128707486b11cebf42735397542a9536c2096568b62d522"
    sha256 cellar: :any_skip_relocation, big_sur:       "acd2a47854a87ba9c65583e9e07aed871e65cfee30ab28934b3b96284e39c76d"
    sha256 cellar: :any_skip_relocation, catalina:      "2cce1de75f570145a3152f616deb19e0ce04041b8d45d97866038e2e10b19024"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4056e12352ef3da54e221f965ceef4071b3399b6ffd53bbe7c0035861adccb14"
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
