# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "b0fc967e1bb99a54d6325bb5df1643e4de193928401c546506a54f188073be91"
    sha256 cellar: :any, arm64_tahoe:       "81d101d9aae03509676790181a9a33260d795766f38ef2e9ca3fa529b731e966"
    sha256 cellar: :any, arm64_sequoia:     "cc17a7ea2c6767ae2d1aef9775887e93e2a7359b8290e9d32322cc767b32d01f"
    sha256 cellar: :any, arm64_linux:       "2d8db4bc1b352bdd731f5fb078172d64f1a23b3e58cfe9977b50134fc2340de5"
    sha256 cellar: :any, x86_64_linux:      "7204aa7532e04760b7de9a945fb471477f88990887c71671dc89720891621d19"
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
