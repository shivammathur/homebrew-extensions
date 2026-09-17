# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9687652b3f6b306feb9b26f1c99d810252c8e61b.tar.gz?commit=9687652b3f6b306feb9b26f1c99d810252c8e61b"
  version "8.6.0"
  sha256 "1a4d3b3b8ed27f9b3e4ac8c9dffd78c81b5b49faafadf261f82d2337732086d4"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any, arm64_golden_gate: "fc9baa597db57a11af0f36a9f130d48e3a64a007c58bd3584912c0eecbe273e3"
    sha256 cellar: :any, arm64_tahoe:       "8f1c726e76d21012a4e904621be10da9dc6e07e9609163dc14a2c05a785d62a4"
    sha256 cellar: :any, arm64_sequoia:     "2726ed26c3085a050ba1480d65ed48eb56498a179d605667adf97779e56b6ad0"
    sha256 cellar: :any, arm64_linux:       "6cd57d0d8d3a725b81ee354699e799a4871027c0d0c6460bebee969ff93f189e"
    sha256 cellar: :any, x86_64_linux:      "388040bbe2152baa8132f087267838047c79a0b78a6c584eedff5492ae5ef13b"
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
