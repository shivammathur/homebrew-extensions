# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/Link--muted.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc1ab610e523daceae7fc34dced73e715299b36340ed0b496e2dd4ed24fa852f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a607c9ddf35cd70c5ef1648a907c877f494eba5bb7b7ffdedabc8a32b275c1b4"
    sha256 cellar: :any_skip_relocation, monterey:       "9523878f038d23ac5fe5590108fa3f65991447de7013f0ecc74a0248b2bc2097"
    sha256 cellar: :any_skip_relocation, big_sur:        "bbfe6cebef68d5354ade99a6db15a7c56bc8cdd75bff2e81ec69e566b01f5b84"
    sha256 cellar: :any_skip_relocation, catalina:       "c2176da50e7b3df75e1c7ad7a075bf9c9cd1ce3e01040776b93045c1932940dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efd3f761a00f96b76e73864d6843bec2ea56f7f365ae4c38536845f6160930b5"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
