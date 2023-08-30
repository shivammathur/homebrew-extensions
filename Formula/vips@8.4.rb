# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7f8de815926e4aa27207d786a2ab72f62c28dd86570cf8467480978bcba78ca3"
    sha256 cellar: :any,                 arm64_big_sur:  "30362970ee034f7424d6a4e233fe981faeb021fad7dd353898def6e461633907"
    sha256 cellar: :any,                 ventura:        "0964c9c2a4af8b7fb7dac13d47ade51b69556bebb96555983f765676c22e0ff1"
    sha256 cellar: :any,                 monterey:       "f78dc6a1174ff0e67aca026019e834b45c0c9462a3f0dc953b1e9ee3a36baaf9"
    sha256 cellar: :any,                 big_sur:        "3307dd19bb94157678b5a7f93b76c44b0ce54795534a5c099a67828f11ec523a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa01cf9679bb760efeabc95dd25fce57646f47ae00dd41a2bfa551908d54f2cc"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
