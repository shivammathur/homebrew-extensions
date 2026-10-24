# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "0c74af3c09c05d30319e992a7d3b24d6c32984f4792638cde515c29608f09a83"
    sha256 cellar: :any, arm64_tahoe:       "8e0d8ab99d91305bbbfc5a6f0cbefcb198fe637f6426f03cff4f4a099d473163"
    sha256 cellar: :any, arm64_sequoia:     "94953ea86ce095cdca1bafb9f012788bfcb6d3259a7144be0db54b77cf651639"
    sha256 cellar: :any, arm64_linux:       "3b927c59c26b3f7acc350000b153c3a3540a3969b4ba3a750e058b96973ecf92"
    sha256 cellar: :any, x86_64_linux:      "2405d3d0801ab406be17e44e35b1ae239f9eb09f0bdc557b572ce956aad47c41"
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
