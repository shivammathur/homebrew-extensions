# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "33f0c51c19191dfb5759043d63730542ad9a65ad5c71a6040f6b693585906bbb"
    sha256 cellar: :any, arm64_sequoia: "cc5726b71d95a6d56257ef7852b925ac885768060bf9521a32df193efe207a51"
    sha256 cellar: :any, arm64_sonoma:  "e8a5df494e632a589e22ed920b1f58cb296332d78fc6e210d2e03bed891f9ebe"
    sha256 cellar: :any, sonoma:        "0cdfbfad0fb1b6fded0d477d3eac23ff855b9cd723b3d14d3121e0754328568b"
    sha256 cellar: :any, arm64_linux:   "71eba537dabe16edbe21918e312865171908d377e32fe5c9c6482dad08505abf"
    sha256 cellar: :any, x86_64_linux:  "ba056cd9bb63a6c8fb32f78135920c55ffbb334cc21ab2f34a6de833c16028e6"
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
