# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/41cda46b70072f97c63692971291346af0e67a45.tar.gz?commit=41cda46b70072f97c63692971291346af0e67a45"
  version "8.3.0"
  sha256 "bafc1bb415ff3f4ce4229cd7c2692f97e6c44f4396702df296ceb22599ab729f"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_monterey: "92915b686facb12190884d6eac57155973d6a2a611a17f4ae0c0a1aa2aa67c60"
    sha256 cellar: :any,                 arm64_big_sur:  "442f2cf860a6bafca889409e2624b274d25a183056ed689d4fc859311df2cc08"
    sha256 cellar: :any,                 ventura:        "8b5bf3e4a5d93b0ac1e639f56a602dc32410e4421a7dfe4360e2bed7e8c4cd3b"
    sha256 cellar: :any,                 monterey:       "c6e0e5a529cf7fafd1c8372a030d90c2235b3d3647fb97208ac7687772f60776"
    sha256 cellar: :any,                 big_sur:        "c03ca747720a3838d8eae34914562ab454a73bda894282ae2e3b661cdd8f6cc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51ceb23952241338683b03b83aa0cd04020db27ce454560c01d149d47e0b9a0f"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
