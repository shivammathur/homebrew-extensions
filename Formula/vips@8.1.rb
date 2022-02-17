# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "653226f7b9d4bf050f35c3887ca717ac2baf833eb567cc04bf398c9f9506214d"
    sha256 cellar: :any,                 big_sur:       "28108e0f6f381aa3384c27ee87e47bdfe668b0a324bb2ecbeab0e4ef6e010a64"
    sha256 cellar: :any,                 catalina:      "542019128b64f51cd14c4d105a59ffeca4d7f1a601cb3cdf4e7af7392a3dd5ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "20d45296b639f94b50f541ac5a48bf4eb77285ce3f9d432cf8e8040323aae6f3"
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
