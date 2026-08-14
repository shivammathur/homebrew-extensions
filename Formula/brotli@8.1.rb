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
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "89d2f7120096d517885807781407352be5a4fdd72212b20854fed4123f4bbfde"
    sha256 cellar: :any, arm64_sequoia: "354608095fa9f451f698530cbb3f19dae4d552f305d286f7e09abaeac82c5d97"
    sha256 cellar: :any, arm64_sonoma:  "2ecebac106d4de7689af408787911f3451ddbb90dd19bfee0d21c1d38a1c891d"
    sha256 cellar: :any, sonoma:        "36787407fd845dbd4f0ca071cb7f871f38875575003ac5ef678331008a313364"
    sha256 cellar: :any, arm64_linux:   "504d2560c573be066a72e86eca59a0a4521109bf9f78febd300287940ef8110e"
    sha256 cellar: :any, x86_64_linux:  "58ff2d79264f7a1da840131e9936b41f0c76e065e7bfb42c0af38fa6596f5d11"
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
