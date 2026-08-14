# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "d7e7759e2c7943f7ff88625bf93244cda54195591b373812f3a63ce449320187"
    sha256 cellar: :any, arm64_sequoia: "6ae546e96261d826514d2e50f23a3f3c351fa3b224332bd795fc85d38a5a7da5"
    sha256 cellar: :any, arm64_sonoma:  "48785c1a9e6c0eb390e0b901aae541f2c8462c3053b13791cbc356fd9e34bfb7"
    sha256 cellar: :any, sonoma:        "8b9cb6bdb64ef8ed41252b49d1ee326e0a50858b4732e2c38bd97f1fb577fba8"
    sha256 cellar: :any, arm64_linux:   "fb444d3183bc96ed8954c6abeb99bb7dad2ea15ed457817c55a0353691a75485"
    sha256 cellar: :any, x86_64_linux:  "155ef8399b20be5bae3ed93d42a59f55db56f57de55e8944f955f7bbbde2f6dc"
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
