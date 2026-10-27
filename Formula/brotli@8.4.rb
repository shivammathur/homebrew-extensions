# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e6a1b4331728a139bf7bbe7de07edd9306ef43b88297da1b026d036e23d28fa7"
    sha256 cellar: :any, arm64_tahoe:       "98fcd4c5403785e95ad3dd6db6b575df0d312c17c3648a6d90563b35368c7746"
    sha256 cellar: :any, arm64_sequoia:     "e98c7267b9a74cb58fe8d3b416435c3a62b3e7e55dd800d84c6a23345219adec"
    sha256 cellar: :any, arm64_linux:       "664be3f9993360315c368e20f63ce5730912b2b1da5e7ebdceca6fbdeefa9618"
    sha256 cellar: :any, x86_64_linux:      "120d3aca889c8ea0e7d058522039ce0a83557491708ca0d5974149b7668a1480"
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
