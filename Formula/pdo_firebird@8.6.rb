# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/eb3b5fc66dcf4cf340d649e63b577c416121e081.tar.gz?commit=eb3b5fc66dcf4cf340d649e63b577c416121e081"
  version "8.6.0"
  sha256 "96cf6bfbd5b89b75f21d81c507be02c63a7491c12267b727d924624e87678cb5"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d43567df6435fc24869f9ef3d591c2f11717f06c44eb762c31baef642c6a97c4"
    sha256 cellar: :any, arm64_tahoe:       "85c65524930eb446fb8f7aeb2a4df180bf21f057b24928658a51ff81c38bcfd6"
    sha256 cellar: :any, arm64_sequoia:     "f48d7453927c739ba607364a638875cc9c61f69b632f42b344a44e0112ec0033"
    sha256 cellar: :any, arm64_linux:       "9aae38de529e6dabe36d9b6582e3f44165419d1d36ec49bf62119078f9d29def"
    sha256 cellar: :any, x86_64_linux:      "492824e08c0749a90baa7277d48444da77bc64aaeb0720c9f6738b96f36da5fa"
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
