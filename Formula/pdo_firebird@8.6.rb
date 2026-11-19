# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e709ba4099085a5ee6a15846c32110873a15474a.tar.gz?commit=e709ba4099085a5ee6a15846c32110873a15474a"
  version "8.6.0"
  sha256 "b980889885fb7c1d448394cd87e3c4062e73a39ffb42a16ff7952b5ab7294cf9"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "00c40c6985c464adc6007885a540fac3eacb1be0c8aadff047bbecc2224a599c"
    sha256 cellar: :any, arm64_tahoe:       "8840d0665e4c75a52931cbaf5ba102d53b8894ee9917c7ad5d7514c89abd77e9"
    sha256 cellar: :any, arm64_sequoia:     "62b2dfad327982888e4535807deee3db4d3c032c9e4663d49f8822887a932834"
    sha256 cellar: :any, arm64_linux:       "0117213e687a6ccb200522cac03e9fb255aa6c7e9155c4f5f6fc2d40dc77ce2f"
    sha256 cellar: :any, x86_64_linux:      "ad8f4bb9c659d972d9d21c628b258dc751cd46e1a7c2af217b608b3914bb2794"
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
