# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "f803ad9adfa66ad9872861e9cd2a29c5abc0a10a9abaa36ac762eccd636b6a23"
    sha256 cellar: :any,                 arm64_ventura:  "e03babc63232252975d8cdf918299cf174b2d6cba83a9d4d808af44c68790326"
    sha256 cellar: :any,                 arm64_monterey: "d84947d29e484cf60c71d4bc5219605903e17ec7c92e8b04d2d621844ca30986"
    sha256 cellar: :any,                 ventura:        "e2882293f4f47b309c4af24886d660963964145f476904f5411ec6ba0818efc5"
    sha256 cellar: :any,                 monterey:       "89f002fad5ae4b3271c481ce58238cc8c705da0dce8d45091147d083d6abb719"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9f539523eb1749da78a9f61fd3c5eded2dbb35b8118bcc4b4e37c5f17339159"
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
