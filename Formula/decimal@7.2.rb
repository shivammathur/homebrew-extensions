# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT72 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://github.com/php-decimal/ext-decimal/archive/v1.5.0.tar.gz"
  sha256 "f00455a058aa22a9c9e7e5c409ee75980068bc9b8f03b17fad39d2bca2138d5d"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/allreleases.xml"
    regex(/<v>(1\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2052ad2f430f4109343fb87859080f18b5d1faf311123ca2529833b783936264"
    sha256 cellar: :any,                 arm64_sonoma:  "c457c2032a2a872a85ed06e0cb67226221e4b2376194072abcc142e34c6e676c"
    sha256 cellar: :any,                 arm64_ventura: "d87ccf86b8e9bae5236d4aa6c82a611915f211a43450b39ca052dfe889cdcd9f"
    sha256 cellar: :any,                 ventura:       "c931a2cf7642031f31198810461db94e6b99310ac6099fab711942de898b7d9c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec55a0bc16f409d54c4096bfdcd5eb8a51e74e4a68806d49f5ba2255328d0f3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84477b42aeb96adce46a9aef5f2a9dc3cd87335802c558bc5977a3f1bec9959c"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
