# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/igbinary@7.4-3.2.12"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5e2151672749e883a9dbfbc4528602600e59b4776a63e301bb32a20990fdbe0f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "697c0d2673272ba3abc1611e31e98231960911e2066a562ee1b1936183e2ec8d"
    sha256 cellar: :any_skip_relocation, monterey:       "ff015e2166472c0eb1706b7d036627afc24395065063c743755f34c4494cf6ea"
    sha256 cellar: :any_skip_relocation, big_sur:        "eeea7701c091aa6c57b2e44c011fe1850e6f9887de332a2165e529b5158110a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ff014ca1dff9fce06c11d84117b32deced80901001d8780da2281eb4ac223da"
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
