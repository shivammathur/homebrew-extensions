# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.32.tar.xz"
  sha256 "8698ec1f9402fa5e5e872ae3d0916b62f5f27503c1fbfc9cc3521e113355ea92"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "59eb2deea0c2126b47f33e11dcb24a9e5dcd3481155244341683c0bc85f732cf"
    sha256 cellar: :any, arm64_sequoia: "c4dc280159a9f6090c27c40dae8349193301083cbb76686685ff3b6b9de063a4"
    sha256 cellar: :any, arm64_sonoma:  "26f4d1624c5f9125f110a977a2a0767db4d49abb511125d3133d75acc5b01ed9"
    sha256 cellar: :any, sonoma:        "5253081e8db9545ad5a6f0282b8b1b286d1d74dbbed2f2a5ac4ed55c90b66d30"
    sha256 cellar: :any, arm64_linux:   "08d65641bf7b5f89f15140045ac06203ab27dc65d0037d206c3f0dea10ce2e87"
    sha256 cellar: :any, x86_64_linux:  "6830f6769e2a9419217c7dd4f63d08b0db3da39bbf04c2a10607cf5a449d74aa"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
