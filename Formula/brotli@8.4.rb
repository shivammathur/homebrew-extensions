# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "e05a1f856ea8daa5c3d75f4253dc1e721bbee8f060eb3f15b40f2bf43a61fbe5"
    sha256 cellar: :any, arm64_sequoia: "b1776a4b07785a7e1b6ab5acfcc4c323ce8bbaa357f81e14f78eb2b16f4277cf"
    sha256 cellar: :any, arm64_sonoma:  "380040a9574e55d6eeba596639aba10bd8578b70cb9fa9bc01a00c710d27400f"
    sha256 cellar: :any, sonoma:        "bb1bcbeeca046f18046995ceb3b96b160f13c28542ac75a00c7fb0fa03e39750"
    sha256 cellar: :any, arm64_linux:   "e932e4694545bf93c69f6f9b2313ba0413664b0cb00ceb1d0f1e5ab5d261cf5a"
    sha256 cellar: :any, x86_64_linux:  "be9734746b8e5a28440d364569f89c9b6ca02cc1e5e9280401489a7d9bbf0d9f"
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
