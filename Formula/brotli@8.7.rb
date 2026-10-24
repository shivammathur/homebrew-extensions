# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT87 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8305ef288ec7b83b89fe11af4de143a9fb9dc573b44ba61f46406e448dcbc18c"
    sha256 cellar: :any, arm64_tahoe:       "c72051a1598f7979a194b52c7a4854cf6c62485527617ff338288f2fa9ced418"
    sha256 cellar: :any, arm64_sequoia:     "a0eefc83dbf26ae52a314c12ca8c8459d68f73d4f53a678de2eb206b46e2eadd"
    sha256 cellar: :any, arm64_linux:       "4e99fdbe655119a8d99f23b98597848071d91534a5be6cf436ee618aa91686b8"
    sha256 cellar: :any, x86_64_linux:      "46efeac1e6ec8688ae704d367f78b8f9618a21691c9ea8df750d722edceab73f"
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
