# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "c065ebd1950665160fc61e08e1214fabaea0b153501cb71bd95c6b9d9ba2122e"
    sha256 cellar: :any, arm64_sequoia: "7ecb8eb099dbb64bcd384317ba590a06910875cd62d1ff74404e83526e49be89"
    sha256 cellar: :any, arm64_sonoma:  "c2c7ea62db2393b1d88131567de40ddc4575c3ce5fc324e24f25fe776e111ac2"
    sha256 cellar: :any, sonoma:        "c2de0cb444c6484b980c0713a8baa20d05d01581dae4b385326daabe7aed8481"
    sha256 cellar: :any, arm64_linux:   "4b54fa737515e46af3332f3aec4ead46c193145c4201ab9858ca777bc750a209"
    sha256 cellar: :any, x86_64_linux:  "7542c3908366df0a95e0c2f8ab69a84918a939465b1c11fd2cfa5bf9e34a68e6"
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
