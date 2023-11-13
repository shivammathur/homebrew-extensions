# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "203d9e5317f856f9bdf071b16ddd20c6dc5e9bf75e20e2d440c850b8cae304f5"
    sha256 cellar: :any,                 arm64_monterey: "1450d1988e0ac36a6bedb4abdef005e476d9adb97d8467d2d7df8a57632cc228"
    sha256 cellar: :any,                 arm64_big_sur:  "ed9dd06f5fc65acabd55b9c05d4e4df5d169cfbe828de69e48945ae9a844ba28"
    sha256 cellar: :any,                 ventura:        "982de982bf01f9eb5691033a00dfb8bd1e394893f3b03d9d1c9eb40ef661b1a5"
    sha256 cellar: :any,                 monterey:       "65de5aa41874b320da03eb3cf5301d73b8fc258e29170f56b1a07743d068546c"
    sha256 cellar: :any,                 big_sur:        "77f6c14710de67e7c0aa755ae7fb57191ec2a6263878d6114f03468e3f706e60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e6ac7af15f84c0443ed870baac13b66b625376099e70d7094a5f6d95fa7726a4"
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
