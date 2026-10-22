# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c242f17cf4bd84654e528353609526c6b97a2213.tar.gz?commit=c242f17cf4bd84654e528353609526c6b97a2213"
  version "8.6.0"
  sha256 "93384fda29ac4cb4282280ba1ef608fdca3e34edb9442d307e13a1cf4c43b8d7"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "6ea5dcea3fe9863a4b008c7da73a4f6d384f6060b92861b9655af2a3d29c0af2"
    sha256 cellar: :any, arm64_tahoe:       "bfb5e07668e389a36e58ff2a88a310ccc95226592e3bc662d72a06563d161315"
    sha256 cellar: :any, arm64_sequoia:     "a2368f8f0fb38ccb0dcbd741ed014ef880e5c13b32ca6b454b17fa9ec35a8374"
    sha256 cellar: :any, arm64_linux:       "aa5a1dd4c891ec0a0157bab779ba9d61ee27862ada77c8fe739074e72fffdc02"
    sha256 cellar: :any, x86_64_linux:      "decde5ce4ee9e49a535c50c39b01e6f4e53dcaf2983234920027b6de2367a816"
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
