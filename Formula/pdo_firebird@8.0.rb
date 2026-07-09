# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/46cd5b65f504f2c67f6906b8b97585f29aec22ce.tar.gz"
  version "8.0.30"
  sha256 "c7788ee61e0452c0de2499c5a2f50e72555fff4a6b325a01f1e4cc950d769fe2"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "2635a3340bd4fcd85a199773d419e6c950bcb4bf9dd1ac0ba67d254c9a9bf330"
    sha256 cellar: :any,                 arm64_sequoia: "936e54c1134e3340e40f8748167dd24931fa795231dba4f604799f73f073d79b"
    sha256 cellar: :any,                 arm64_sonoma:  "7f81bd840d75f1de3bf08b7594e4a2e2c23d2e79e46bf617918bb40b997c6307"
    sha256 cellar: :any,                 sonoma:        "48cac772f92e227e6ee858734293cd5e1eeec0f80110924dc8f3dadbc93479e7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bca24ed95b80c65ae7597a9af9a34a7575241319a28bda9e501ebc5a5fafbf74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a2584a0942b8b791c0cfd91bfa462fe24bd5971928809ec432d42f1f15b35a5b"
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
