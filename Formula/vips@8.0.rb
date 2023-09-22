# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_ventura:  "2a154eb4ce6f95bfad692c675f5c7fcc964b94821d241d265a5f484ee2bd8ffa"
    sha256 cellar: :any,                 arm64_monterey: "ae969e0a82e2be99482730b92b14d18dbf498b8ec691c0d857c4271aef8aaa31"
    sha256 cellar: :any,                 arm64_big_sur:  "f22ba2ab99af891a3b001f53cd13fd8b9adb1b57e966db2b22037cb71c1558ba"
    sha256 cellar: :any,                 ventura:        "a7616f54f85ecff8d74b34a66d91bc84aa62abbe4ff6c7c86f31e3226430b29a"
    sha256 cellar: :any,                 monterey:       "567a4293ab0858d8c41bfb5b0b579369a37776d275d5b9cdecee6c81a15bd37a"
    sha256 cellar: :any,                 big_sur:        "961d2cfbb9fd120c34abaa6a7a3f353342928b4d715e67268f6437aeaa32a9a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81848c2f56342332eebe1648f2a727851ab7c26f34906a6211b4fa2e046efddc"
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
