# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0fb074d860346877aa33eee8131a6eaf4a932608.tar.gz?commit=0fb074d860346877aa33eee8131a6eaf4a932608"
  version "8.7.0"
  sha256 "a8f694482347f3d4d4b710de5782cb395ac66cd1743a285bb62fbc10388dfbb3"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    manifest_sha256 "119890bd9f7dd309fcbcfe00c388c4961d69f3a8f915498c1dfe7b97f4cf7754"
    sha256 cellar: :any, arm64_golden_gate: "8c5bc3a7df92dd76875dec3293b4fd2004d3d97cdec03c2ea0b4b372e4788da8"
    sha256 cellar: :any, arm64_tahoe:       "9a213db37f56e65a5d04f0e81b9e15e94fc3b6f5adf0881dce91fb5514de618c"
    sha256 cellar: :any, arm64_sequoia:     "8863d4a5596254dec14e1eb3582c709f4b21f4ad5e2cedcc7962f75f95e30b96"
    sha256 cellar: :any, arm64_linux:       "f1265533da7dc7851ee2f2453990e365cdb0b4926290b28b223c1934772a2e12"
    sha256 cellar: :any, x86_64_linux:      "c6e1d4f8724e2ebdef981de24bb3fe0f31fa2ff668b6042cbc3f5544db6c25e0"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
