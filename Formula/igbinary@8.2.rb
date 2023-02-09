# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.13.tar.gz"
  sha256 "4400ecefafe0901c2ead0e1770b0d4041151e0c51bcb27c4a6c30becb1acb7da"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1c1aa30e3ae9cb5daca88ef7254b99e8f87425bc2f3fb3062fa92d02a0e8ba2b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "14977a06a5ab885df83406b7186ccc229bca056205f14d68243205a551f4cdc5"
    sha256 cellar: :any_skip_relocation, monterey:       "3820278832751d9f28ab335327b16d30bd5401ad8bdd4b28190c0702be2eb046"
    sha256 cellar: :any_skip_relocation, big_sur:        "8b747288d6dec5e2aa4465df53567d05b71f858c01d146883528de2ca91420b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49177bef798de98393950d19df17cb5cec32689b70f8031ab13cb885e7cbdb1b"
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
