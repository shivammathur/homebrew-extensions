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
    rebuild 22
    sha256 cellar: :any, arm64_golden_gate: "21262c2dd8817e43ef90efdd46ccc2fa8017fbc1b15e21c1a80a0bc1bb89bcd4"
    sha256 cellar: :any, arm64_tahoe:       "88a2d8abc9744c373006b730caa922ec960562249d935976b7fe80ee6db8856a"
    sha256 cellar: :any, arm64_sequoia:     "7569af398adc07c4507b7e9db450c9641242446c774f7f23c5bdb8f273536551"
    sha256 cellar: :any, arm64_linux:       "8267ec42c3f43835262d3a54ab16a4d7fa8e2afd3b3357d86825b20230ec3f51"
    sha256 cellar: :any, x86_64_linux:      "1a6edc66828591348c84110b0230b9fb3668c6a5b4228d8c4c6acbd712e52463"
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
