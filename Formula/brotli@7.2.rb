# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "83361e4dac0326940b0c11ca5cdd00d58ccc772823bd25c52e5bd7aae2c05301"
    sha256 cellar: :any, arm64_sequoia: "19732a749e7f3836dd79e0b76e1bd0ada3ff102a72146d3bc783d5338fc534f5"
    sha256 cellar: :any, arm64_sonoma:  "94317d6e2bc2d21d673bc100099d1300ca60e0aadbb674f168c038f8780968ce"
    sha256 cellar: :any, sonoma:        "9d274cf690441d2c46ec50a4fcd62c8ce7ffc9dc967b78436a089d13910e8f3b"
    sha256 cellar: :any, arm64_linux:   "9ea608ca41dc323bf9abf66ddbca94a899c087e08e31d97c60fa8505c3033e94"
    sha256 cellar: :any, x86_64_linux:  "4bcff80c3fd1f295b153168e03168d8b8ecc9fd8dc252c7d715fc75ac302e5e5"
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
