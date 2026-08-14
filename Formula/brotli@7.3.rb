# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "bedab4bc4ddd947400e89937fa3a8d8398e0e53d34a1cd12334d27784614a35e"
    sha256 cellar: :any, arm64_sequoia: "d16e49e3af475b4b4da2a08444134ab41216ba09a2255569b8e49bcce0613f70"
    sha256 cellar: :any, arm64_sonoma:  "accde287e42884e054b79ab88bb6fbea8854a22bf6ebcad60262532681c0b7e7"
    sha256 cellar: :any, sonoma:        "c56a3ca281de88a4862a69877879b1763ec8e037854380cc7e65240d11f35e08"
    sha256 cellar: :any, arm64_linux:   "3cd2d0b525e9a16f68ddb8fa1f10f5b522458f561cb222a8f0c5ee7f31b2ab5d"
    sha256 cellar: :any, x86_64_linux:  "8c01cac352f6db108d5f534017235228c56fff827716ea0d21079d7177998ed2"
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
