# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6c516f2cc9bc2fce405a8dff76018d71947948dc37f55c9257928b670ca26bba"
    sha256 cellar: :any, arm64_tahoe:       "83b3c38f65570ee60f8253c1f7a4a1795572c5d1c04ca4bfbec20240b8a7b309"
    sha256 cellar: :any, arm64_sequoia:     "e08540755f200a07bd3c1ae2df9f19c86e0f6bcbf42cf769d1ac643409a71aa7"
    sha256 cellar: :any, arm64_linux:       "a00b6e01bd4493a16caaf65ad5afc25ebf370b55c6af6d88dbfa68945a1bce95"
    sha256 cellar: :any, x86_64_linux:      "d63790c2d05eae01fea10af1bb4ae98f6e54cf63a966be84a0d14e9fc2b2b366"
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
