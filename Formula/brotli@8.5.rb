# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT85 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c7a39584266e0b6037936b3c6182f066a01452245d2572edb4169c845342d0f8"
    sha256 cellar: :any,                 arm64_sequoia: "9408a5986d396962bb9ba42a2bc5d0a20930102a8c73642c10573c028e2b6af8"
    sha256 cellar: :any,                 arm64_sonoma:  "1dfa6d021a14bca685d73e42bbd7879ae027f85293dedc3da65fc8ac8da8b5cb"
    sha256 cellar: :any,                 sonoma:        "0e7f62354ae8088d22ae5a42b7e0b3d5e5a7074c0a62afb0b9eb140c7cc158bc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "091612df883de57c10f803a7c178e2812de63059e32ece5920269603718dcc6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9dc5f9a346b1d15f44acc2146a493962612c778dccb383deebc76574d57730e"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
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
