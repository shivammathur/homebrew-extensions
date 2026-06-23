# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT81 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1fb4cd209c8d7a0b942e40adb01527816b01fb2d87aa8ee4c7fa7f279d0a62c0"
    sha256 cellar: :any, arm64_sequoia: "1525baef515346b61c6e37820a44a25494fe18e0f9768b84b6f26a06f933fb50"
    sha256 cellar: :any, arm64_sonoma:  "c67e67af8f211758dad9bfe8afa44e76998615bf8de16e76d367a5bb00d1ef8f"
    sha256 cellar: :any, sonoma:        "023d6494256cd617cbc0dd0d21469a22027d604b722ec7aec95d633d3632c5ae"
    sha256 cellar: :any, arm64_linux:   "fd985c6211466b336a052cd506d12c8968b036e5078ce14c4fe2246e2c6c5706"
    sha256 cellar: :any, x86_64_linux:  "7c4b7fb73818e8e01776f026f4bd676bcf57c79ef46306073025ee4912653b78"
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
