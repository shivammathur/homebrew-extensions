# typed: false
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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "55bcd7ec12913889b45e9aaf9cfaae556a89fd9fa5c610daa09114b3f26417cf"
    sha256 cellar: :any,                 arm64_big_sur:  "2f2fea1c02b8e1b2b64a547e0cd25ac01250ba259dbf898fe9f65c301e5c4bc4"
    sha256 cellar: :any,                 monterey:       "2434763ba5948a4a1f8cff04cd3e75e47f481cdec0625ac7b40cfd02d7bc8450"
    sha256 cellar: :any,                 big_sur:        "c76b7699945b21e7ba2f0cc7dc2d621f005a32821c7bb723874539de65eb05de"
    sha256 cellar: :any,                 catalina:       "bd3846ca4e308a6e07588c6c212d8ef25c38ff8113b7200a29b0448804bfeb3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bb89cc3e6deaef8c299fce0059c2dffe2ae032385e11ccab24b79d94bc4ebcb"
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
