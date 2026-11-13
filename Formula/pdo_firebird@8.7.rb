# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5a8fda322b0bd0835b0fd0021358fa2309f6cea8.tar.gz?commit=5a8fda322b0bd0835b0fd0021358fa2309f6cea8"
  version "8.7.0"
  sha256 "f422cca206e773b8e1733d842e8e1a8676cb412f77b276ebb4613b6472be6f47"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6d0aa3000d01e8cd1f1e43a73107f40a45b677a8c8967358a77d73f38e6c5809"
    sha256 cellar: :any, arm64_tahoe:       "57b1380c50750cf4a5f9a2a32d1a4e605f7ff123a2d0d46c838ece19a025f226"
    sha256 cellar: :any, arm64_sequoia:     "cabc79514608766249a7a48492b8506f5095573addd39d2678fb514f6dd0045b"
    sha256 cellar: :any, arm64_linux:       "3ef2e87c508db78a90c64a727806d3a4d11b7a5e4bfa70ad01c08945258f1a34"
    sha256 cellar: :any, x86_64_linux:      "b6b30b9f5c9c30b2721b85924acf04bc555719f6600e7e5912f857077fd73a46"
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
