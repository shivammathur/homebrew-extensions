# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "1b408fec4a3a92c98d45571a00a32472253b5581f56ad23b0ab05ac6d20ff5af"
    sha256 cellar: :any, arm64_sequoia: "d42e5340be4a2830138215813775e2dce09f8bebb0bbaa98d04c1bbaf0a43e5a"
    sha256 cellar: :any, arm64_sonoma:  "1c5a7682fa165b7ff34eca7a434676bfdf5e3d1d59385669d8d5bb19ea418af5"
    sha256 cellar: :any, sonoma:        "142f809fef3e987f9965639278e85289a296b9e045445c7e7ad7c256ce60003b"
    sha256 cellar: :any, arm64_linux:   "60e4effa7e6e73e42f28301c21a06367fa9530d465fdf1d145dac1afdb77e147"
    sha256 cellar: :any, x86_64_linux:  "daf88ac2f8af6ccfbcd39f3bca2a7ba890bb1d8f0d85bbfcf32207c947ce1a93"
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
