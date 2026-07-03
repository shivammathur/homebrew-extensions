# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "8931ff14aca335df03f71c5d98cce1b7db0d3de04c5081abde4beca8c1374985"
    sha256 cellar: :any, arm64_sequoia: "54a00ab861f5ca6a465c468f0f1f83af3de20229fcdf42a71f8ee8475fc85829"
    sha256 cellar: :any, arm64_sonoma:  "d8acf7b004291949ce140cb5cdc3088334d4c95eaf02dd397df0cbc107739ca2"
    sha256 cellar: :any, sonoma:        "47ca5ff43b50139030df5a5fa1ddacc661ed6b254e51f813ae71402f9f9eaaf2"
    sha256 cellar: :any, arm64_linux:   "9ce4405f67950c30feb6a636171faf6cce9da0e7ed90600be39681542eb9f570"
    sha256 cellar: :any, x86_64_linux:  "1ec802d482c410bd3411f82cc6b1c7db60d2ef0bb75e973bc496c9287e5703e2"
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
