# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a576d8eb53e44aff3af9259cfd29e599f604471.tar.gz"
  version "7.4.33"
  sha256 "d82887f2166e8526ea9b1cfd8c5ecf5649718f0b6e341380d333eba8066429a4"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "e0936e931b3192cb601103ca8b6b9e6825cb8d746631161a3e41df1cdae4d2a1"
    sha256 cellar: :any, arm64_sequoia: "4ad3759e36f8d4a6fb1a21158cd3de705423d38bf7f42c7ea5ad42a067cceaa3"
    sha256 cellar: :any, arm64_sonoma:  "d4b384a67ed50a3249dbb26207de3531c92204d9d193809691ea15185da82c4c"
    sha256 cellar: :any, sonoma:        "bc1629effc280a83c0c83c4da90d993f57215ca8a2ac022f14d96918053b2d82"
    sha256 cellar: :any, arm64_linux:   "752f34d463b638dadf71928f50b1bf7724eb7b53efd556d7b516972307b7317c"
    sha256 cellar: :any, x86_64_linux:  "7501d041596967d210f1939237ba911ee7bc53b1398f35e8fd6ae3eedcdb47b1"
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
