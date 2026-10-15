# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ee90c4416b2dabd488c58fc10f23c1559cd57.tar.gz"
  version "7.3.33"
  sha256 "1ec8487f024bb3bb9ab18a09c72b4e6cbe71bad362f4188b191f5bb6e59ad371"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "35d6e90a608dae6ff03c02f0b561bd0982703bb3c135503e57375d659926d6fa"
    sha256 cellar: :any, arm64_tahoe:       "fc0aed420c57ed623902a62bd2d1608607b36192421edcf16a8222ce9155317b"
    sha256 cellar: :any, arm64_sequoia:     "fa1819d10c1a703b9aabb3ef7d607d10a229d4944b7bfb0195960c7e9e48198a"
    sha256 cellar: :any, arm64_linux:       "825da183357f8631e3672df7e3f8a9cbaf27e5956d66e558b2f9eb7d868db979"
    sha256 cellar: :any, x86_64_linux:      "8b8270ae6da81ad87a572823ae5f67e63d5628f971994dba6fb8c7a1ea49c78e"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
