# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "1d8ba1cf25246db7f7ede0ddd8767cf4bbe2b86ccf31901ece1e81a40f51ef2d"
    sha256 cellar: :any, arm64_tahoe:       "5ca3f6621bed39dcf2ecaec40d4506549ea281ebb39388d48e6af6f58169663d"
    sha256 cellar: :any, arm64_sequoia:     "705d262ddb53e8585e465d9db6da25d53ee93ae2fcc0c50ac6bb0a155b5db4cb"
    sha256 cellar: :any, arm64_linux:       "7272002749deba1369ca6ced9785e140430dcd79c345226fa6d13127c41e4a4b"
    sha256 cellar: :any, x86_64_linux:      "4b12f02d2d8e43c94569f4dee4c5cf7bdbda5ec190a875eb26f5b03d761e09ec"
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
