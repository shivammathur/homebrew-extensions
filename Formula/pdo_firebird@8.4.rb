# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.24.tar.xz"
  sha256 "e127be09a8506f4327c5cfa78a614b00d210714484ec215ce0011b4a03c00731"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "f52d287161c1e3d21b507ed6266ceb35cb3247e0582832238eaa23f311c46316"
    sha256 cellar: :any, arm64_sequoia: "28c6db386759c8f61301516cb0d0e74b13aaf4f3353f9ff9047818aeec2b7757"
    sha256 cellar: :any, arm64_sonoma:  "1ffb5a070f2f7ad5dd893c5a7c50ca70691e2d7a3ed4a82bda5882e725b0d107"
    sha256 cellar: :any, sonoma:        "da65c47e5c4bb19d007ab7563741f989b0d723ea8dd34c46df08b708ae7bc078"
    sha256 cellar: :any, arm64_linux:   "067982cd259b02150eaa036bbac6b2ccda4b9b1dfbbb36d2c193ffb355a2dcfb"
    sha256 cellar: :any, x86_64_linux:  "9ea3012caa3bf53797efdce3834bfc81280a6f1c6858356acac9cf79bea5c105"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
