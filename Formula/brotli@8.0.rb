# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "ac329a4f9f96814593e7f7f31476a7592cafac95daac374b068da5ede9323579"
    sha256 cellar: :any, arm64_tahoe:       "ae663f955768534a964178af5f3acedaf54d5c12e8b408e002326d78fdaed598"
    sha256 cellar: :any, arm64_sequoia:     "7f503ec66a698ee838084b30dbe7ff3aae674bc0fa6d3eb068961d232dea312f"
    sha256 cellar: :any, arm64_linux:       "a415d6ea90e19bf15b4be46d3c4fc0a090f1b9013eba4fe5482902da71571111"
    sha256 cellar: :any, x86_64_linux:      "a72764d557b25a1b907a55cfaee4a9fd6425aae22f286c3496b1801406fdac5f"
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
