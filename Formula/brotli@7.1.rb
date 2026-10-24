# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "2cca461f4c2d2439b975dc06f2cdd5fd8ef8f5435bdf094d84e5a3dd86c7e64b"
    sha256 cellar: :any, arm64_tahoe:       "29b4ca87070756ff39bfc9655b626a7f3897faa4308dba6b5c397b8b97edcf38"
    sha256 cellar: :any, arm64_sequoia:     "03add1937d568973024012ff60f5a83e9ca6e41aa8256bbd8ad6361c8be66a42"
    sha256 cellar: :any, arm64_linux:       "11293a3635683f7574cbbdfaf22bc0bbf0a13355a10d534b9d20219679274ee7"
    sha256 cellar: :any, x86_64_linux:      "7752346bf752cc5636722d0d7c758ed9b05651be4280c1aa78e4d71bdf4cfb76"
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
