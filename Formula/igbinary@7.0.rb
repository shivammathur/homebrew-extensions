# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "94842abb66f1303a45a0b8a40302289c57fce6a0f2e9c142c415f3e61a68b4c9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5bdec477553129e0a63d67c012a1ac5911943f50ef25d187b316ac013648b33c"
    sha256 cellar: :any_skip_relocation, monterey:       "1d76703e159451ee796d9ed4b8bd2b32927b8f26431ba0ca4abde96aa5a45a91"
    sha256 cellar: :any_skip_relocation, big_sur:        "bb47b365f32542a51990c21d3df4c82b8c9feb1c5f5bc3177a713d8a1f2052aa"
    sha256 cellar: :any_skip_relocation, catalina:       "7562c9204cd5ebdbb3e9595299fe258753136fa072c7010a56fcebd4529d593f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8b0a431049747e9573f344e70142038d7f453087c363e9e851d08fe85a42d94"
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
