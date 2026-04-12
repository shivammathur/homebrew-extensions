# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT83 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7d68a2851da3f919deb17aef8b3274387ddb1f9628dd8c48892b6f321fc63888"
    sha256 cellar: :any,                 arm64_sequoia: "4c7f9252cfd56b0898da38df2303df4816acdeffbca0a6bbfc55780e3a045139"
    sha256 cellar: :any,                 arm64_sonoma:  "b0be4c6cac15f2b1271033eee786d883aafff0d90297b4406ab49634c95a839c"
    sha256 cellar: :any,                 sonoma:        "5a476ac2232990e601864d4e24e17e30864d6d71c53d91e871a25e614d06e79a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "174ebd7c811b0e3d8e80154619ab6d70094105fc0c6ffa4ee11e319017802f3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87d18779bb2c8802cab165176ad92cbf7be5cd366cd06e2ea7ae0abfa89ecf6d"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
