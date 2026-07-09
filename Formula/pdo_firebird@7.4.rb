# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/850206cc862858e460587305d0bfa802cc46ea2e.tar.gz"
  version "7.4.33"
  sha256 "d3d7b7ad536398743a06adba0c3bce23eae340e0f05d946a4059f01e841b7de9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "b9d6111226602bdd9bde9964a41ed6e2b88dd14366ba1531d6fc50c20af35eda"
    sha256 cellar: :any, arm64_sequoia: "ea847867be5e2e26a83b73610c3931995b08e9d0b9a67a0391890ea620f7309f"
    sha256 cellar: :any, arm64_sonoma:  "a3198872263983e708b87dcbc66b96cd0f632685e5152a582fa61e8c474c421c"
    sha256 cellar: :any, sonoma:        "6ea4181a507dde9aecf6a34087b3085d6c7e2489dd42666dd59852e9caa37b7e"
    sha256 cellar: :any, arm64_linux:   "e38deb2fdfaf755cd837d77d89ddc123859e91a2c8efef2e67eab37837310fe3"
    sha256 cellar: :any, x86_64_linux:  "95c9fd52e51078d321b0dd37a9f6ac430669b86b17450c1e223261b4443e2232"
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
