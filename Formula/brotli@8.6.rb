# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "b6ced24faacaf1402805e191dedd349c83f4d9e41f2facd99b07ad78aa1b108c"
    sha256 cellar: :any, arm64_tahoe:       "40e41ce83ddc9d83e7542934504b313cf35a2f48fa9bccbf981398eeb81c04fd"
    sha256 cellar: :any, arm64_sequoia:     "c0d04377a31e8d07fb3989353140189e38005cbfb654d3a602fdbf0314bcd276"
    sha256 cellar: :any, arm64_linux:       "223cddb0b0dc6162a2850b7bc27a7cfda5cdef387d563c1bb0b1dd47caac0cd2"
    sha256 cellar: :any, x86_64_linux:      "be0790b9703d5a34b0f4ba45dafb7cd068bd787b44028de35cc0a420dec8f72b"
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
