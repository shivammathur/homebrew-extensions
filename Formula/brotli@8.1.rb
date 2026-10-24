# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "ccc1ceec1e18c34038981a6503095d326d76ed052ea397dd1ee31569c217d729"
    sha256 cellar: :any, arm64_tahoe:       "c7acf9ee496a24beb57329c2cf0cb3f97050a92fc0f26870ffce2a1d27b311f1"
    sha256 cellar: :any, arm64_sequoia:     "e3ba49a047f1433ee3b508836d1fef7a07bc5ed48862d4d662b31bfb02837f5d"
    sha256 cellar: :any, arm64_linux:       "cb647bfed764a9588a1671e78af1182566eaa4f8502faff5171ac89b951f6bef"
    sha256 cellar: :any, x86_64_linux:      "14f3cc4d2a5acb67053ce6cb79b477ec5b5da2b323a85b21be908ea34d851b90"
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
