# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.20.0.tgz"
  sha256 "e8d303afa3df0afc4e1362496482e3d20052b3bb478027b597073c8114d1f2ea"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "71b0c0a61f786dc7d07471779bf87ce6c8f2cc966ca2cbc40090b8c5e4e7d27f"
    sha256 cellar: :any, arm64_sequoia: "5b91eafa1283f974b53395770c8950785bd73ecb8f933e81d8648400ffbf1274"
    sha256 cellar: :any, arm64_sonoma:  "14fe2d1cf363f00d81ca4b4eb10c345cdf6e05ab4940e2bc2db61ae0704c2322"
    sha256 cellar: :any, sonoma:        "ae3a71cd5e710c4834ddd2bf3640d49262f78739974bd6909a4ccf3c5124e0e7"
    sha256 cellar: :any, arm64_linux:   "88022f1ff43e25a8037afa614928835486cb24a30da732f485dfa83d6f5c3139"
    sha256 cellar: :any, x86_64_linux:  "38dd5f77734bc1064cffc7ee53afd086f62f2e52d160af9458d714cdb518793a"
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
