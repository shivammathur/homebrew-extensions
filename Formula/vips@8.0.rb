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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "15fdce562e14914642f5a2c862058199899451987aaf8ab69816ca48096d3642"
    sha256 cellar: :any,                 arm64_big_sur:  "ccf256aa47dfe528d0138e360d98118a3eab15d1959c1d7910bfe45863a21370"
    sha256 cellar: :any,                 monterey:       "48ebda7421775916c38303c98ad61f8ffd3a9985255af935aa600c52f084424d"
    sha256 cellar: :any,                 big_sur:        "913c8fb8d5200bd595196f7062151917b01e197a9917984ed34f2c976a332427"
    sha256 cellar: :any,                 catalina:       "fd7a3a6da175f151cb45cdceed00d66c67df3fa37dbf5c902cb912102857ad77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27a63410da52c04b9e7e24ab76a0a5155194d3976a97e5deeb83bb4cf8df4d9a"
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
