# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "ab5b2dea00845306b9803d07c7ca0736d5ed18aac2063ede1d5cb1dba4e317e7"
    sha256 cellar: :any, arm64_tahoe:       "38a5cb8d2b7b14943a1b185a97b85d9d1396efd940dd1faaf9f0440df1dd66dd"
    sha256 cellar: :any, arm64_sequoia:     "087f0e6d6815de0c719b08091612b5ffeded070506cdb7eb583aac582ca98273"
    sha256 cellar: :any, arm64_linux:       "29f5c5a6e6f775da0dbbd278f0218c0b8108fe4f2e798322dc0abe88dacb397e"
    sha256 cellar: :any, x86_64_linux:      "b9bbd3215570388809e27b0a29cccb82ef84c5d10b3745e91fd790b527e34f0a"
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
