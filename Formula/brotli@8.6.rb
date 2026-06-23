# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "98bccd911193166f6ddbaccea7539841d990628f7c6b82a60899cf5ff84bda45"
    sha256 cellar: :any, arm64_sequoia: "7d67a3241eb40850f8e82375c1075ca3759a6df1f30d9e77d08be44ef288f14c"
    sha256 cellar: :any, arm64_sonoma:  "29a566ece92ba80a12741bc278e36401df54383e228b5e016a3bf85d2abb9170"
    sha256 cellar: :any, sonoma:        "3254d40954b4d091f63075f2118dfcd2b5de06ff856caf16d7d8cf75cb5d0fb0"
    sha256 cellar: :any, arm64_linux:   "4f4d4f757290a09f25385ba63dc8f7ce3d32159126d1a7e1eb7351b4cdcf6cab"
    sha256 cellar: :any, x86_64_linux:  "0dcb4ba62838af92636b198a51889eeb0f342b9f040f4fe9eccddf2cfd6959c7"
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
