# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "87e8e9a881dbf541c2b02dbb390e602e049f218535afe6d0e553a2627d3c13cc"
    sha256 cellar: :any, arm64_tahoe:       "8a25129cf7038b13c10f99d91d909a884527e93c5356227603dd21a816d3feb7"
    sha256 cellar: :any, arm64_sequoia:     "52cc6e20f72542b02c6b325fbcefdf494695c01d310a2c6f76f773f0a6b855cd"
    sha256 cellar: :any, arm64_linux:       "c32ce611bde9bca0fc10bcd22e80d68a2e6d0016b2e6b0ad20c22e8f6e769c10"
    sha256 cellar: :any, x86_64_linux:      "715dbcd649f91fefddae878068117f74e4e0d5c36c1ee3be8e386927cb776fda"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
